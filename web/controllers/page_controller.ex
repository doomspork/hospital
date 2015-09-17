defmodule Hospital.PageController do
  use Hospital.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
