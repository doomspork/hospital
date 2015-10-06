defmodule Hospital.ReportSummaryControllerTest do
   use Hospital.ConnCase, async: false

  alias Hospital.HealthCheck
  alias Hospital.Medic
  alias Hospital.Report
  alias Hospital.User

  setup do
    conn = conn()

    user = Repo.insert!(%User{email: ""})
    %{id: health_check_id} = Repo.insert!(%HealthCheck{user_id: user.id})
    %{id: medic_id} = Repo.insert!(%Medic{})

    Repo.insert!(%Report{medic_id: medic_id, health_check_id: health_check_id, successful: true, response_time: 52.0})

    {:ok, conn: conn, user: user}
  end

  test "requires permissions", %{conn: conn} do
    conn = get conn, report_summary_path(conn, :index)
    assert conn.state == :sent
    assert conn.status == 401
  end

  test "returns a health check summary", %{conn: conn, user: user} do
    conn = sign_in conn, user
    conn = get conn, report_summary_path(conn, :index)
    assert conn.state == :sent
    assert conn.status == 200
  end
end
