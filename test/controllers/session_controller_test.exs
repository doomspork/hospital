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

  test "creates a new session and redirects" do
    conn = post conn, login_path(conn, :create), user: %{email: @email, password: @password}
    assert conn.state == :sent
    assert conn.status == 200

    results = conn.resp_body
    json = Poison.decode!(results)["data"]
    assert json["token"]
  end

  test "does not create a new session when data is invalid" do
    conn = post conn, login_path(conn, :create), user: %{email: @email, password: "another password"}
    assert conn.state == :sent
    assert conn.status == 401

    results = conn.resp_body
    error = Poison.decode!(results)["error"]
    assert error == "Bad login."
  end
end
