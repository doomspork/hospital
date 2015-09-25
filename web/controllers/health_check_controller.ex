defmodule Hospital.HealthCheckController do
  use Hospital.Web, :controller

  alias Hospital.HealthCheck
  alias Hospital.SessionController

  plug Guardian.Plug.EnsureAuthenticated, %{ on_failure: { SessionController, :new } } when not action in [:new, :create]
  plug Guardian.Plug.EnsurePermissions, %{ on_failure: { __MODULE__, :forbidden }, default: [:read, :write] } when action in [:edit, :update]

  plug :scrub_params, "health_check" when action in [:create, :update]

  def index(conn, _params) do
    health_checks = Repo.all(HealthCheck)
    render(conn, "index.html", health_checks: health_checks)
  end

  def new(conn, _params) do
    changeset = HealthCheck.create_changeset(%HealthCheck{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"health_check" => params}) do
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

  #  def show(conn, %{"id" => id}) do
  #    health_check = Repo.get!(HealthCheck, id)
  #    render(conn, "show.html", health_check: health_check)
  #  end
  #
  #  def edit(conn, %{"id" => id}) do
  #    health_check = Repo.get!(HealthCheck, id)
  #    changeset = HealthCheck.changeset(health_check)
  #    render(conn, "edit.html", health_check: health_check, changeset: changeset)
  #  end
  #
  #  def update(conn, %{"id" => id, "health_check" => health_check_params}) do
  #    health_check = Repo.get!(HealthCheck, id)
  #    changeset = HealthCheck.changeset(health_check, health_check_params)
  #
  #    case Repo.update(changeset) do
  #      {:ok, health_check} ->
  #        conn
  #        |> put_flash(:info, "Health check updated successfully.")
  #        |> redirect(to: health_check_path(conn, :show, health_check))
  #      {:error, changeset} ->
  #        render(conn, "edit.html", health_check: health_check, changeset: changeset)
  #    end
  #  end
  #
  #  def delete(conn, %{"id" => id}) do
  #    health_check = Repo.get!(HealthCheck, id)
  #
  #    # Here we use delete! (with a bang) because we expect
  #    # it to always work (and if it does not, it will raise).
  #    Repo.delete!(health_check)
  #
  #    conn
  #    |> put_flash(:info, "Health check deleted successfully.")
  #    |> redirect(to: health_check_path(conn, :index))
  #  end
end
