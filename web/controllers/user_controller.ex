defmodule Hospital.UserController do
  use Hospital.Web, :controller

  alias Hospital.User
  alias Hospital.SessionController

  plug :scrub_params, "user" when action in [:create]

  def create(conn, %{"user" => user_params}) do
    changeset = User.create_changeset(%User{}, user_params)

    if changeset.valid? do
      case Repo.insert(changeset) do
        {:ok, user} ->
          conn = Guardian.Plug.sign_in(conn, user, :token, perms: %{ default: Guardian.Permissions.max })
          token = Guardian.Plug.current_token(conn)

          conn
          |> render("show.json", user: Map.put(user, :token, token))
        {:error, _changeset} ->
          conn
          |> render("error.json", error: "User already exists.")
      end
    else
      conn
      |> render("error.json", error: "An error occurred creating a new account.")
    end
  end

  def show(conn, _) do
    current_resource = Guardian.Plug.current_resource(conn)
    token = Guardian.Plug.current_token(conn)
    case current_resource do
      %User{} -> render(conn, "show.json", user: Map.put(current_resource, :token, token))
      nil -> SessionController.unauthenticated_api(conn)
    end
  end
end
