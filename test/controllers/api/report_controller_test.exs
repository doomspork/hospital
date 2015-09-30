defmodule Hospital.Api.ReportControllerTest do
  use Hospital.ConnCase

  alias Hospital.Report

  @valid_attrs %{successful: true, results: %{}, health_check_id: 1, medic_id: 1}
  @invalid_attrs %{}

  setup do
    Repo.insert!(%Hospital.HealthCheck{id: 1})
    Repo.insert!(%Hospital.Medic{id: 1})

    conn = conn()
    claims = %{ "sub" => "user", "aud" => "aud" }
             |> Guardian.Claims.app_claims
             |> Guardian.Claims.permissions(%{medic: [:write]})

    { :ok, jwt } = Joken.encode(claims)

    {:ok, conn: conn, jwt: jwt}
  end

  test "requires permissions", %{conn: conn} do
    conn = post conn, report_api_path(conn, :create), report: @valid_attrs
    assert conn.state == :sent
    assert conn.status == 401
  end

  test "creates and renders resource when data is valid", %{conn: conn, jwt: jwt} do
    conn = put_req_header(conn, "authorization", "Bearer #{jwt}")
    conn = post conn, report_api_path(conn, :create), report: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Report, @valid_attrs)
  end
end
