defmodule Hospital.UserController do
  use Hospital.Web, :controller

  alias Hospital.User
  alias Hospital.SessionController

  plug Guardian.Plug.EnsureAuthenticated, %{ on_failure: { SessionController, :new } } when not action in [:new, :create]
  plug Guardian.Plug.EnsurePermissions, %{ on_failure: { SessionController, :forbidden }, default: [:read, :write] } when action in [:edit, :update]

  plug :scrub_params, "user" when action in [:create, :update]

  def new(conn, _params) do
    changeset = User.create_changeset(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.create_changeset(%User{}, user_params)

    if changeset.valid? do
      case Repo.insert(changeset) do
        {:ok, user} ->
          conn
          |> put_flash(:info, "User created successfully.")
          |> Guardian.Plug.sign_in(user, :token, perms: %{ default: Guardian.Permissions.max })
          |> redirect(to: page_path(conn, :index))
        {:error, _changeset} ->
          conn
          |> put_flash(:error, "User already exists.")
          |> render("new.html", changeset: changeset)
      end
    else
      conn
      |> put_flash(:error, "An error occurred creating a new account.")
      |> render("new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get(User, id)
    render(conn, "show.html", user: user)
  end

  def edit(conn, %{"id" => id}) do
    user = Repo.get(User, id)
    changeset = User.update_changeset(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Repo.get(User, id)
    changeset = User.update_changeset(user, user_params)

    if changeset.valid? do
      Repo.update(changeset)

      conn
      |> put_flash(:info, "User updated successfully.")
      |> redirect(to: page_path(conn, :index))
    else
      render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Repo.get(User, id)
    Repo.delete(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: page_path(conn, :index))
  end
end
