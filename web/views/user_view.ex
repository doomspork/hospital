defmodule Hospital.UserView do
  use Hospital.Web, :view

  def render("show.json", %{user: user}) do
    %{data: render_one(user, __MODULE__, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{email: user.email,
      id: user.id,
      name: user.name}
  end
end
