defmodule Hospital.Api.ReportController do
  use Hospital.Web, :controller

  alias Hospital.Report
  alias Hospital.SessionController

  plug Guardian.Plug.EnsureAuthenticated, %{ on_failure: { SessionController, :unauthenticated_api } }
  plug Guardian.Plug.EnsurePermissions, medic: [:write], on_failure: { SessionController, :forbidden_api }
  plug :scrub_params, "report" when action in [:create]

  def create(conn, %{"report" => report_params}) do
    report_params = complete_params(conn, report_params)
    changeset = Report.create_changeset(%Report{}, report_params)

    case Repo.insert(changeset) do
      {:ok, report} ->
        conn
        |> put_status(:created)
        |> render(Hospital.ReportView, "show.json", report: report)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Hospital.ChangesetView, "error.json", changeset: changeset)
    end
  end

  defp complete_params(conn, params) do
    %{id: id} = Guardian.Plug.current_resource(conn)
    timestamp = params["time"]
                |> :calendar.gregorian_seconds_to_datetime

    Map.merge(params, %{"checked_at" => timestamp, "medic_id" => id})
  end
end
