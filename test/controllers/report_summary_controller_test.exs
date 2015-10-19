defmodule Hospital.ReportSummaryControllerTest do
  use Hospital.ConnCase

  alias Hospital.HealthCheck
  alias Hospital.Medic
  alias Hospital.Report
  alias Hospital.User

  setup do
    conn = conn()

    user = Repo.insert!(%User{email: "test@example.com"})
    %{id: health_check_id} = Repo.insert!(%HealthCheck{user_id: user.id})
    %{id: medic_id} = Repo.insert!(%Medic{})

    Repo.insert!(%Report{medic_id: medic_id, health_check_id: health_check_id, successful: true, response_time: 52.0})

    string_id = to_string(health_check_id)

    {:ok, conn: conn, health_check_id: string_id, user: user}
  end

  test "requires permissions", %{conn: conn} do
    conn = get conn, report_summary_path(conn, :index)
    assert conn.state == :sent
    assert conn.status == 401
  end

  test "returns a health check summary", %{conn: conn, health_check_id: health_check_id, user: user} do
    conn = sign_in conn, user
    conn = get conn, report_summary_path(conn, :index)
    assert conn.state == :sent
    assert conn.status == 200

    results = conn.resp_body
    json = Poison.decode!(results)
    assert length(json["data"][health_check_id]["series"]["avg"]) == 61
  end

  test "returns a complete timeseries without reports", %{conn: conn} do
    user = Repo.insert!(%User{email: "user@example.com"})
    %{id: health_check_id} = Repo.insert!(%HealthCheck{user_id: user.id})

    conn = sign_in conn, user
    conn = get conn, report_summary_path(conn, :index)
    assert conn.state == :sent
    assert conn.status == 200

    results = conn.resp_body
    json = Poison.decode!(results)
    string_id = to_string(health_check_id)
    assert length(json["data"][string_id]["series"]["avg"]) == 61
  end

end
