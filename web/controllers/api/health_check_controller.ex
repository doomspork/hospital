defmodule Hospital.Api.HealthCheckController do
  use Hospital.Web, :controller

  import Ecto.Query

  alias Hospital.HealthCheck
  alias Hospital.SessionController

  plug Guardian.Plug.EnsureAuthenticated, %{ on_failure: { SessionController, :unauthenticated_api } }
  plug Guardian.Plug.EnsurePermissions, medic: [:read], on_failure: { SessionController, :forbidden_api }

  def index(conn, _params) do
    query = from h in HealthCheck,
            select: h
    health_checks = Repo.all(query)
    render(conn, "index.json", health_checks: health_checks)
  end
end
