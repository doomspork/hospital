defmodule Hospital.Api.ReportController do
  use Hospital.Web, :controller

  alias Hospital.Report
  alias Hospital.SessionController

  plug Guardian.Plug.EnsureAuthenticated, %{ on_failure: { SessionController, :unauthenticated_api } }
  plug Guardian.Plug.EnsurePermissions, medic: [:write], on_failure: { SessionController, :forbidden_api }
  plug :scrub_params, "report" when action in [:create]

  def create(conn, %{"report" => report_params}) do
    resource = Guardian.Plug.current_resource(conn)
    complete_params = Map.merge(report_params, %{"checked_at" => report_params["timestamp"],"medic_id" => resource.id})
    changeset = Report.create_changeset(%Report{}, complete_params)

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
end
