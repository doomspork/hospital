defmodule Hospital.ReportSummaryView do
  use Hospital.Web, :view

  def render("index.json", %{report_summaries: summaries}) do
    %{data: render_one(summaries, __MODULE__, "report_summary.json")}
  end

  def render("report_summary.json", %{report_summary: summary}) do
    summary
  end
end
