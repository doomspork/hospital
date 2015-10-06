defmodule Hospital.ReportSummaryController do
  use Hospital.Web, :controller

  import Ecto.Query

  alias Hospital.HealthCheck
  alias Hospital.Report
  alias Hospital.SessionController
  alias Hospital.User

  plug Guardian.Plug.EnsureAuthenticated, %{ on_failure: { SessionController, :unauthenticated_api } }

  def index(conn, _params) do
    uptimes = conn
              |> Guardian.Plug.current_resource
              |> calculate_uptimes

    summaries = report_summaries
    unless Enum.empty?(summaries) do
      summaries = consolidate_summaries(summaries, uptimes)
    end

    render(conn, "index.json", report_summaries: summaries)
  end

  defp calculate_uptimes(user) do
    user
    |> users_health_checks
    |> last_applicable_reports
  end

  defp consolidate_summaries(summaries, uptimes) do
    Enum.reduce(uptimes, summaries, fn ({id, uptime}, acc) ->
      updated_summary = Map.put(acc[id], :uptime, uptime)
      Map.put(summaries, id, updated_summary)
    end)
  end

  defp users_health_checks(%User{id: id}) do
    query = from h in HealthCheck,
            select: h.id,
            where: h.user_id == ^id

    Repo.all(query)
  end

  defp days_since(inserted_at) do
    now  = :calendar.universal_time |> :calendar.datetime_to_gregorian_seconds
    then = inserted_at |> Ecto.DateTime.to_erl |> :calendar.datetime_to_gregorian_seconds
    diff = now - then

    {days, _time} = :calendar.seconds_to_daystime(diff)

    days
  end

  defp flatten_summaries(%{avg: avg, max: max, min: min, minutes: minutes}) do
    average = Enum.sum(avg) / Enum.count(avg)
    %{avg: average,
      max: Enum.max(max),
      min: Enum.min(min),
      minutes: minutes}
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

  defp last_applicable_reports(ids) do
    successes = first_successes(ids)
    failures  = last_failures(ids)

    successes
    |> Map.merge(failures)
    |> Enum.map(fn {k, v} -> {k, days_since(v)} end)
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

  defp report_dates_to_map(reports) do
    reports
    |> Enum.map(fn ([id|[date]]) -> {to_string(id), date} end)
    |> Enum.into(%{})
  end

  defp last_twenty_four_hours do
    seconds = :calendar.universal_time |> :calendar.datetime_to_gregorian_seconds
    seconds - (60 * 60 * 24)
    |> :calendar.gregorian_seconds_to_datetime
    |> Ecto.DateTime.from_erl
  end

  defp reduce_summaries(summary, %{avg: avg, max: max, min: min, minutes: minutes}) do
    %{avg: [summary.avg|avg],
      max: [summary.max|max],
      min: [summary.min|min],
      minutes: [Map.delete(summary, :minute)|minutes]}
  end

  defp report_summaries(since \\ last_twenty_four_hours) do
    since
    |> summary_query
    |> Repo.all
    |> Enum.group_by(&(&1.health_check_id))
    |> Enum.map(fn {k, v} ->
      flat_v = v
               |> Enum.reduce(%{avg: [], max: [], min: [], minutes: []}, &reduce_summaries/2)
               |> flatten_summaries
      {to_string(k), flat_v}
    end)
    |> Enum.into(%{})
  end

  defp summary_query(since) do
    from r in Report,
    select: %{minute: fragment("date_trunc('minute', ?)", field(r, :inserted_at)),
              avg: avg(r.response_time),
              min: min(r.response_time),
              max: max(r.response_time),
              health_check_id: r.health_check_id},
    group_by: [r.inserted_at, r.health_check_id],
    where: r.successful == true and r.inserted_at > ^since
  end
end
