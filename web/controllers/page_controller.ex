defmodule Hospital.PageController do
  use Hospital.Web, :controller

  alias Hospital.SessionController

  plug Guardian.Plug.EnsureAuthenticated, %{ on_failure: { SessionController, :new } } when not action in [:index]

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def settings(conn, _params) do
    render(conn, "settings.html")
  end

  def dashboard(conn, _params) do
    render(conn, "dashboard.html")
  end
end
