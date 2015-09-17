defmodule Hospital.ReportControllerTest do
  use Hospital.ConnCase

  alias Hospital.Report

  @valid_attrs %{address: "some content", results: %{}, type: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, report_path(conn, :create), report: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Report, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, report_path(conn, :create), report: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end
end
