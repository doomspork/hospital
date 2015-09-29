defmodule Hospital.Api.HealthCheckController do
  use Hospital.Web, :controller

  import Ecto.Query

  alias Hospital.HealthCheck
  alias Hospital.Medic
  alias Hospital.SessionController
  alias Hospital.User

  plug Guardian.Plug.EnsureAuthenticated, %{ on_failure: { SessionController, :unauthenticated_api } }
  plug Guardian.Plug.EnsurePermissions, default: [:read], on_failure: { SessionController, :forbidden_api }

  def index(conn, _params) do
    health_checks = conn
                    |> Guardian.Plug.current_resource
                    |> health_checks_query
    render(conn, "index.json", health_checks: health_checks)
  end

  defp health_checks_query(%User{id: id}) do
    query = from h in HealthCheck,
            select: h,
            where: h.user_id == ^id

    Repo.all(query)
  end

  defp health_checks_query(%Medic{}) do
    query = from h in HealthCheck,
            select: h

    Repo.all(query)
  end
end
