defmodule Hospital.HostControllerTest do
  use Hospital.ConnCase

  alias Hospital.Host

  @valid_attrs %{address: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, host_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    host = Repo.insert! %Host{}
    conn = get conn, host_path(conn, :show, host)
    assert json_response(conn, 200)["data"] == %{"id" => host.id,
      "address" => host.address}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, host_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, host_path(conn, :create), host: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Host, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, host_path(conn, :create), host: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    host = Repo.insert! %Host{}
    conn = put conn, host_path(conn, :update, host), host: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Host, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    host = Repo.insert! %Host{}
    conn = put conn, host_path(conn, :update, host), host: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    host = Repo.insert! %Host{}
    conn = delete conn, host_path(conn, :delete, host)
    assert response(conn, 204)
    refute Repo.get(Host, host.id)
  end
end
