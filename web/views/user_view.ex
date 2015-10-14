defmodule Hospital.UserView do
  use Hospital.Web, :view

  def render("show.json", %{user: user}) do
    %{data: render_one(user, __MODULE__, "user.json")}
  end

  def render("error.json", %{error: error}) do
    %{error: error}
  end

  def render("user.json", %{user: user}) do
    %{email: user.email,
      id: user.id,
      name: user.name,
      token: user.token}
  end
end
