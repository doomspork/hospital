defmodule Hospital.Api.HealthCheckControllerTest do
   use Hospital.ConnCase

  setup do
    conn = conn()
    claims = %{ "sub" => "user", "aud" => "aud" }
             |> Guardian.Claims.app_claims
             |> Guardian.Claims.permissions(%{medic: [:read]})

    { :ok, jwt } = Joken.encode(claims)

    {:ok, conn: conn, jwt: jwt}
  end

  test "requires permissions", %{conn: conn} do
    conn = get conn, health_check_api_path(conn, :index)
    assert conn.state == :sent
    assert conn.status == 401
  end

  test "returns a list of health checks", %{conn: conn, jwt: jwt} do
    conn = put_req_header(conn, "authorization", "Bearer #{jwt}")
    conn = get conn, health_check_api_path(conn, :index)
    assert conn.state == :sent
    assert conn.status == 200
  end
end
