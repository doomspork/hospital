defmodule Hospital.HealthCheckController do
  use Hospital.Web, :controller

  import Ecto.Query

  alias Hospital.HealthCheck
  alias Hospital.SessionController

  plug Guardian.Plug.EnsureAuthenticated, %{ on_failure: { SessionController, :new } }
  plug :scrub_params, "health_check" when action in [:create, :update]


  def index(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    query = from h in HealthCheck,
          where: h.user_id == ^user.id,
         select: h
    health_checks = Repo.all(query)
    render(conn, "index.html", health_checks: health_checks)
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

  def edit(conn, %{"id" => id}) do
    case user_health_check(conn, id) do
      nil -> forbidden(conn)
      health_check ->
        changeset = HealthCheck.create_changeset(health_check)
        render(conn, "edit.html", health_check: health_check, changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "health_check" => health_check_params}) do
    case user_health_check(conn, id) do
      nil -> forbidden(conn)
      health_check ->
        changeset = HealthCheck.create_changeset(health_check, health_check_params)

        case Repo.update(changeset) do
          {:ok, health_check} ->
            conn
            |> put_flash(:info, "Health check updated successfully.")
            |> redirect(to: health_check_path(conn, :show, health_check))
          {:error, changeset} ->
            render(conn, "edit.html", health_check: health_check, changeset: changeset)
        end
    end
  end

  def delete(conn, %{"id" => id}) do
    case user_health_check(conn, id) do
      # Here we use delete! (with a bang) because we expect
      # it to always work (and if it does not, it will raise).
      nil -> forbidden(conn)
      health_check ->
        Repo.delete!(health_check)

        conn
        |> put_flash(:info, "Health check deleted successfully.")
        |> redirect(to: health_check_path(conn, :index))
    end
  end

  def forbidden(conn, _ \\ :empty) do
    conn
    |> put_flash(:error, "Forbidden")
    |> redirect(to: health_check_path(conn, :index))
  end

  defp user_health_check(conn, id) do
    user = Guardian.Plug.current_resource(conn)
    query = from h in HealthCheck,
          where: h.id == ^id and h.user_id == ^user.id,
         select: h
    Repo.one(query)
  end
end
