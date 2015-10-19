defmodule Hospital.SessionController do
  use Hospital.Web, :controller

  alias Hospital.User

  plug :scrub_params, "user" when action in [:create]

  def create(conn, params = %{}) do
    user = User.from_email(params["user"]["email"] || "")
    if user do
      changeset = User.login_changeset(user, params["user"])
      if changeset.valid? do
        conn = Guardian.Plug.sign_in(conn, user, :token, perms: %{ default: Guardian.Permissions.max })
        token = Guardian.Plug.current_token(conn)

        conn
        |> render(Hospital.UserView, "show.json", user: Map.put(user, :token, token))
      else
        conn
        |> put_status(401)
        |> render(Hospital.UserView, "error.json", error: "Bad login.")
      end
    else
      conn
      |> put_status(401)
      |> render(Hospital.UserView, "error.json", error: "Login not found.")
    end
  end

  def delete(conn, _params) do
    Guardian.Plug.sign_out(conn)
    |> put_flash(:info, "Logged out successfully.")
    |> redirect(to: login_path(conn, :new))
  end

  def unauthenticated_api(conn, _params \\ :empty) do
    the_conn = put_status(conn, 401)
    case Guardian.Plug.claims(conn) do
      { :error, :no_session } -> json(the_conn, %{ error: "Login required" })
      { :error, reason } -> json(the_conn, %{ error: reason })
      _ -> json(the_conn, %{ error: "Login required" })
    end
  end

  def forbidden_api(conn, _ \\ :empty) do
    conn
    |> put_status(403)
    |> json(%{ error: :forbidden })
    |> halt
  end

  def forbidden(conn, _) do
    conn
    |> put_status(403)
    |> put_flash(:error, "Forbidden")
    #|> redirect(to: page_path(conn, :index))
  end
end
