defmodule Hospital.ReportSummaryController do
  use Hospital.Web, :controller

  import Ecto.Query

  alias Hospital.HealthCheck
  alias Hospital.Report
  alias Hospital.SessionController
  alias Hospital.User

  plug Guardian.Plug.EnsureAuthenticated, %{ on_failure: { SessionController, :unauthenticated_api } }

  def index(conn, _params) do
    health_check_ids = conn
                       |> Guardian.Plug.current_resource
                       |> users_health_checks

    uptimes = calculate_uptimes(health_check_ids)

    summaries = health_check_ids
                |> report_summaries
                |> consolidate_summaries(uptimes)

    render(conn, "index.json", report_summaries: summaries)
  end

  defp calculate_uptimes(health_check_ids) do
    successes = first_successes(health_check_ids)
    failures  = last_failures(health_check_ids)

    successes
    |> Map.merge(failures)
    |> Enum.map(fn {k, v} -> {k, days_since(v)} end)
    |> Enum.into(%{})
  end

  defp consolidate_summaries(summaries, uptimes) do
    summaries
    |> Enum.map(fn {id, summary} ->
         uptime = Map.get(uptimes, id)
         updated = Map.put(summary, :uptime, uptime)
         {id, updated}
       end)
    |> Enum.into(%{})
  end

  defp datetime_as_seconds(date \\ :calendar.universal_time)
  defp datetime_as_seconds({date, {hour, minute, _seconds, _milli}}) do
    datetime_as_seconds({date, {hour, minute, 0}})
  end
  defp datetime_as_seconds({date, {hour, minute, _seconds}}) do
    {date, {hour, minute, 0}} |> :calendar.datetime_to_gregorian_seconds
  end

  defp days_since(inserted_at) do
    now  = :calendar.universal_time |> :calendar.datetime_to_gregorian_seconds
    then = inserted_at |> Ecto.DateTime.to_erl |> :calendar.datetime_to_gregorian_seconds
    diff = now - then

    {days, _time} = :calendar.seconds_to_daystime(diff)

    days
  end

  defp first_successes(ids) do
    query = from r in Report,
            select: [r.health_check_id, r.inserted_at],
            distinct: r.health_check_id,
            where: r.successful == true and r.health_check_id in ^ids,
            group_by: [r.health_check_id, r.inserted_at],
            order_by: [asc: r.inserted_at]

    query
    |> Repo.all
    |> report_dates_to_map
  end


  defp health_check_summary(reports, padding) do
    timeseries = report_timeseries(reports)

    padding
    |> Map.merge(timeseries)
    |> Enum.reduce(%{avg: [], max: [], min: []}, &reduce_summaries/2)
    |> summarize
  end

  defp last_failures(ids) do
    query = from r in Report,
            select: [r.health_check_id, r.inserted_at],
            distinct: r.health_check_id,
            where: r.successful == false and r.health_check_id in ^ids,
            group_by: [r.health_check_id, r.inserted_at],
            order_by: [desc: r.inserted_at]

    query
    |> Repo.all
    |> report_dates_to_map
  end

  defp last_hour do
    seconds = :calendar.universal_time |> :calendar.datetime_to_gregorian_seconds
    seconds - (60 * 60)
    |> :calendar.gregorian_seconds_to_datetime
    |> Ecto.DateTime.from_erl
  end

  defp padded_timeseries(since) do
    since = since
            |> Ecto.DateTime.to_erl
            |> datetime_as_seconds
    now = datetime_as_seconds
    diff = (now - since) / 60

    padded_timeseries(since, diff)
  end

  defp padded_timeseries(time, remaining, acc \\ %{})
  defp padded_timeseries(_time, -1.0, acc), do: acc
  defp padded_timeseries(time, remaining, acc) do
    acc = Map.put(acc, time, nil)
    padded_timeseries(time + 60, remaining - 1, acc)
  end

  defp report_dates_to_map(reports) do
    reports
    |> Enum.map(fn ([id|[date]]) -> {to_string(id), date} end)
    |> Enum.into(%{})
  end

  defp reduce_summaries({_k, nil}, acc) do
    {nil, %{avg: nil, max: nil, min: nil}}
    |> reduce_summaries(acc)
  end
  defp reduce_summaries({_k, %{avg: avg, max: max, min: min}}, %{avg: averages, max: maxes, min: mins}) do
    %{avg: [avg|averages], max: [max|maxes], min: [min|mins]}
  end

  defp report_summaries(health_check_ids, since \\ last_hour) do
    padding = padded_timeseries(since)

    grouped = since
              |> summary_query
              |> Repo.all
              |> Enum.group_by(&(&1.health_check_id))

    health_check_ids
    |> Enum.map(fn id ->
        summary = grouped
                  |> Map.get(id)
                  |> health_check_summary(padding)

       {to_string(id), summary}
     end)
    |> Enum.into(%{})
  end

  defp report_timeseries(nil), do: %{}
  defp report_timeseries(reports) do
    reports
    |> Enum.reduce(%{}, fn (%{avg: avg, max: max, min: min, minute: minute}, acc) ->
        seconds = datetime_as_seconds(minute)
        Map.put(acc, seconds, %{avg: avg, max: max, min: min})
    end)
  end

  defp summarize(%{avg: avg, max: max, min: min} = series) do
    avg = avg
          |> Enum.reject(&(&1 == nil))

    average = case avg do
      [] -> nil
      list -> Enum.sum(list) / Enum.count(list)
    end

    max = Enum.reject(max, &(&1 == nil))
    max = case max do
      [] -> nil
      list -> Enum.max(list)
    end

    %{avg: average,
      max: max,
      min: Enum.min(min),
      series: series}
  end

  defp summary_query(since) do
    from r in Report,
    select: %{minute: fragment("date_trunc('minute', ?)", field(r, :checked_at)),
              avg: avg(r.response_time),
              min: min(r.response_time),
              max: max(r.response_time),
              health_check_id: r.health_check_id},
    group_by: [r.checked_at, r.health_check_id],
    where: r.successful == true and r.checked_at > ^since
  end

  defp users_health_checks(%User{id: id}) do
    query = from h in HealthCheck,
            select: h.id,
            where: h.user_id == ^id

    Repo.all(query)
  end
end
