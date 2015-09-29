defmodule Hospital.Api.HealthCheckControllerTest do
  use Hospital.ConnCase

  import Hospital.TestHelper

  alias Hospital.HealthCheck
  alias Hospital.Medic
  alias Hospital.User

  setup do
    conn = conn()

    user = Repo.insert!(%User{email: "test@example.com"})
    medic = Repo.insert!(%Medic{})
    Repo.insert!(%HealthCheck{user_id: user.id})
    Repo.insert!(%HealthCheck{})

    {:ok, conn: conn, user: user, medic: medic}
  end

  test "requires permissions", %{conn: conn} do
    conn = get conn, health_check_api_path(conn, :index)
    assert conn.state == :sent
    assert conn.status == 401
  end

  test "returns a list of health checks for a Medic", %{conn: conn, medic: medic} do
    conn = sign_in conn, medic
    conn = get conn, health_check_api_path(conn, :index)
    assert conn.state == :sent
    assert conn.status == 200

    json = Poison.decode!(conn.resp_body)
    assert length(json["data"]) == 2
  end

  test "returns a list of health checks for a User", %{conn: conn, user: user} do
    conn = sign_in conn, user
    conn = get conn, health_check_api_path(conn, :index)
    assert conn.state == :sent
    assert conn.status == 200

    results = conn.resp_body
    json = Poison.decode!(results)
    assert length(json["data"]) == 1
  end

end
