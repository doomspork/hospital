defmodule Hospital.ReportView do
  use Hospital.Web, :view

  def render("index.json", %{reports: reports}) do
    %{data: render_many(reports, Hospital.ReportView, "report.json")}
  end

  def render("show.json", %{report: report}) do
    %{data: render_one(report, Hospital.ReportView, "report.json")}
  end

  def render("report.json", %{report: report}) do
    %{id: report.id,
      address: report.address,
      type: report.type,
      results: report.results}
  end
end
