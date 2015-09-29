defmodule Hospital.Api.ReportController do
  use Hospital.Web, :controller

  alias Hospital.Report
  alias Hospital.SessionController

  plug Guardian.Plug.EnsureAuthenticated, %{ on_failure: { SessionController, :unauthenticated_api } }
  plug Guardian.Plug.EnsurePermissions, medic: [:write], on_failure: { SessionController, :forbidden_api }
  plug :scrub_params, "report" when action in [:create]

  def create(conn, %{"report" => report_params}) do
    changeset = Report.create_changeset(%Report{}, report_params)

    case Repo.insert(changeset) do
      {:ok, report} ->
        conn
        |> put_status(:created)
        |> render("show.json", report: report)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Hospital.ChangesetView, "error.json", changeset: changeset)
    end
  end
end
