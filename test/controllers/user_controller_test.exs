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

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, signup_path(conn, :create), user: @invalid_attrs

    results = conn.resp_body
    error = Poison.decode!(results)["error"]
    assert error =~ "An error occurred"
  end

  test "does not create resource and renders errors when account exists", %{conn: conn} do
    %User{}
    |> User.create_changeset(@valid_attrs)
    |> Repo.insert!

    conn = post conn, signup_path(conn, :create), user: @valid_attrs

    results = conn.resp_body
    error = Poison.decode!(results)["error"]
    assert error == "User already exists."
  end
end
