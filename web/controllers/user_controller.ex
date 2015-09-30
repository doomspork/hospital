defmodule Hospital.UserController do
  use Hospital.Web, :controller

  alias Hospital.User
  alias Hospital.SessionController

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

  def show(conn, _) do
    current_resource = Guardian.Plug.current_resource(conn)
    case current_resource do
      %User{} -> render(conn, "show.json", user: current_resource)
      nil -> SessionController.unauthenticated_api(conn)
    end
  end
end
