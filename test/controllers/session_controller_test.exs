defmodule Hospital.SessionControllerTest do
  use Hospital.ConnCase

  @email "test@example.com"
  @password "a hard password"

  setup do
    user_params = %{email: @email, name: "Test User", password: @password, password_confirmation: @password}

    %Hospital.User{}
    |> Hospital.User.create_changeset(user_params)
    |> Repo.insert!

    conn = conn()
    {:ok, conn: conn}
  end

  test "renders login form" do
    conn = get conn, login_path(conn, :new)
    assert html_response(conn, 200) =~ "Login"
  end

  test "creates a new session and redirects" do
    conn = post conn, login_path(conn, :create), user: %{email: @email, password: @password}
    assert redirected_to(conn) == page_path(conn, :index)
  end

  test "does not create a new session when data is invalid" do
    conn = post conn, login_path(conn, :create), user: %{email: @email, password: "another password"}
    assert html_response(conn, 200) =~ "Login"
  end
end
