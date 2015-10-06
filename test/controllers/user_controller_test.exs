defmodule Hospital.UserControllerTest do
  use Hospital.ConnCase, async: false

  alias Hospital.User
  @valid_attrs %{email: "user@example.com",
                 password: "a hard password",
                 password_confirmation: "a hard password",
                 name: "Test User"}
  @invalid_attrs %{}

  setup do
    conn = conn()

    user = Repo.insert!(%User{email: "test@example.com"})

    {:ok, conn: conn, user: user}
  end

  test "returns account when logged in", %{conn: conn, user: user} do
    conn = sign_in(conn, user)
    conn = get(conn, account_path(conn, :show))
    assert conn.status == 200

    results = conn.resp_body
    json = Poison.decode!(results)
    assert json["data"]["email"] == user.email
  end

  test "does not return account when logged out", %{conn: conn} do
    conn = get(conn, account_path(conn, :show))
    assert conn.state == :sent
    assert conn.status == 401
  end

  test "renders sign up form", %{conn: conn} do
    conn = get conn, signup_path(conn, :new)
    assert html_response(conn, 200) =~ "Signup"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, signup_path(conn, :create), user: @valid_attrs
    assert redirected_to(conn) == page_path(conn, :index)
    assert Repo.get_by(User, email: @valid_attrs.email)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    post conn, signup_path(conn, :create), user: @invalid_attrs
    # Flash messages are temporarily removed from the layout
    #assert html_response(conn, 200) =~ "An error occurred creating a new account."
  end

  test "does not create resource and renders errors when account exists", %{conn: conn} do
    %User{}
    |> User.create_changeset(@valid_attrs)
    |> Repo.insert!

    post conn, signup_path(conn, :create), user: @valid_attrs
    # Flash messages are temporarily removed from the layout
    #assert html_response(conn, 200) =~ "User already exists."
  end
end
