defmodule Hospital.Api.HealthCheckView do
  use Hospital.Web, :view

  def render("index.json", %{health_checks: health_checks}) do
    %{data: render_many(health_checks, Hospital.Api.HealthCheckView, "health_check.json")}
  end

  def render("show.json", %{health_check: health_check}) do
    %{data: render_one(health_check, Hospital.Api.HealthCheckView, "health_check.json")}
  end

  def render("health_check.json", %{health_check: health_check}) do
    %{id: health_check.id,
      options: health_check.options,
      name: health_check.name,
      regions: health_check.regions,
      target: health_check.target,
      type: health_check.type}
  end
end
