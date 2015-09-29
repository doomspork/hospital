defmodule Hospital.UserControllerTest do
  use Hospital.ConnCase

  alias Hospital.User
  @valid_attrs %{email: "user@example.com",
                 password: "a hard password",
                 password_confirmation: "a hard password",
                 name: "Test User"}
  @invalid_attrs %{}

  setup do
    conn = conn()

    {:ok, conn: conn}
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
    conn = post conn, signup_path(conn, :create), user: @invalid_attrs
    assert html_response(conn, 200) =~ "An error occurred creating a new account."
  end

  test "does not create resource and renders errors when account exists", %{conn: conn} do
    %User{}
    |> User.create_changeset(@valid_attrs)
    |> Repo.insert!

    conn = post conn, signup_path(conn, :create), user: @valid_attrs
    assert html_response(conn, 200) =~ "User already exists."
  end

  #test "shows chosen resource", %{conn: conn, user: user} do
  #  conn = sign_in(conn, user)
  #  conn = get conn, user_path(conn, :show, user)
  #  assert html_response(conn, 200) =~ "Show user"
  #end

  #test "renders form for editing chosen resource", %{conn: conn, user: user} do
  #  conn = sign_in(conn, user)
  #  conn = get conn, user_path(conn, :edit, user)
  #  assert html_response(conn, 200) =~ "Edit user"
  #end

  #test "updates chosen resource and redirects when data is valid", %{conn: conn, user: user} do
  #  conn = sign_in(conn, user)
  #  conn = put conn, user_path(conn, :update, user), user: @valid_attrs
  #  assert redirected_to(conn) == user_path(conn, :index)
  #  assert Repo.get_by(User, email: @valid_attrs.email)
  #end

  #test "deletes chosen resource", %{conn: conn} do
  #  user = Repo.insert! %User{}
  #  conn = sign_in(conn, user)
  #  conn = delete conn, user_path(conn, :delete, user)
  #  assert redirected_to(conn) == user_path(conn, :index)
  #  refute Repo.get(User, user.id)
  #end
end
