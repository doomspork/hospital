defmodule Hospital.HealthCheckControllerTest do
  use Hospital.ConnCase

  alias Hospital.HealthCheck
  alias Hospital.User

  setup do
    conn = conn()

    user = Repo.insert!(%User{email: "test@example.com"})
    Repo.insert!(%HealthCheck{user_id: user.id})
    Repo.insert!(%HealthCheck{})

    {:ok, conn: conn, user: user}
  end

  test "requires permissions", %{conn: conn} do
    conn = get conn, health_check_path(conn, :index)
    assert conn.state == :sent
    assert conn.status == 401
  end

  test "returns a list of health checks for a User", %{conn: conn, user: user} do
    conn = sign_in conn, user
    conn = get conn, health_check_path(conn, :index)
    assert conn.state == :sent
    assert conn.status == 200

    results = conn.resp_body
    json = Poison.decode!(results)
    assert length(json["data"]) == 1
  end
end
