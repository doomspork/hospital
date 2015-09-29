defmodule Hospital.Api.ReportView do
  use Hospital.Web, :view

  def render("index.json", %{reports: reports}) do
    %{data: render_many(reports, Hospital.Api.ReportView, "report.json")}
  end

  def render("show.json", %{report: report}) do
    %{data: render_one(report, Hospital.Api.ReportView, "report.json")}
  end

  def render("report.json", %{report: report}) do
    %{health_check_id: report.health_check_id,
      id: report.id,
      medic_id: report.medic_id,
      results: report.results,
      successful: report.successful}
  end
end
