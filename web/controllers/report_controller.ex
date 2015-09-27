defmodule Hospital.ReportController do
  use Hospital.Web, :controller

  alias Hospital.Report

  plug :scrub_params, "report" when action in [:create]

  def index(conn, _params) do
    reports = Repo.all(Report)
    render(conn, "index.json", reports: reports)
  end

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

  def show(conn, %{"id" => id}) do
    report = Repo.get!(Report, id)
    render conn, "show.json", report: report
  end
end
