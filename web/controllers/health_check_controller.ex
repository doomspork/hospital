defmodule Hospital.HealthCheckController do
  use Hospital.Web, :controller

  import Ecto.Query

  alias Hospital.HealthCheck
  alias Hospital.SessionController
  alias Hospital.User

  plug Guardian.Plug.EnsureAuthenticated, %{ on_failure: { SessionController, :unauthenticated_api } }
  plug :retrieve_health_checks

  def index(conn, _params) do
    render(conn, "index.json", health_checks: conn.assigns[:health_checks])
  end

  def new(conn, _params) do
    changeset = HealthCheck.create_changeset(%HealthCheck{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"health_check" => params}) do
    user = Guardian.Plug.current_resource(conn)
    params = Map.put(params, "user_id", user.id)
    changeset = HealthCheck.create_changeset(%HealthCheck{}, params)

    case Repo.insert(changeset) do
      {:ok, _health_check} ->
        conn
        |> put_flash(:info, "Health check created successfully.")
        |> redirect(to: health_check_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, _) do
    render(conn, "show.json", health_check: conn.assigns[:health_check])
  end

  def update(_conn, %{"health_check" => _params}) do
  end

  def delete(conn, _) do
    case Repo.delete(conn.assigns[:health_check]) do
      {:ok, health_check} -> render(conn, "show.json", health_check: health_check)
      {:error, _} -> SessionController.forbidden_api(conn)
    end
  end

  defp retrieve_health_checks(%Plug.Conn{params: %{"id" => id}} = conn, _) do
    %User{id: user_id} = Guardian.Plug.current_resource(conn)
    query = from h in HealthCheck,
            select: h,
            where: h.user_id == ^user_id and h.id == ^id

    case Repo.one(query) do
      %HealthCheck{} = health_check ->
        assign(conn, :health_check, health_check)
      nil ->
        SessionController.forbidden_api(conn)
    end
  end

  defp retrieve_health_checks(conn, _) do
    %User{id: user_id} = Guardian.Plug.current_resource(conn)

    query = from h in HealthCheck,
            select: h,
            where: h.user_id == ^user_id

    health_checks = Repo.all(query)
    assign(conn, :health_checks, health_checks)
  end
end
