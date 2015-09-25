defmodule Hospital.HealthCheckTest do
  use Hospital.ModelCase

  alias Hospital.HealthCheck
  alias Hospital.User

  @create_attrs %{name: "", target: "", type: "ping", user: %User{}}

  test "create changeset with valid attributes" do
    changeset = HealthCheck.create_changeset(%HealthCheck{}, @create_attrs)
    assert changeset.valid?
  end

  test "create changeset with invalid attributes" do
    invalid_attrs = Map.delete(@create_attrs, :name)
    changeset = HealthCheck.create_changeset(%HealthCheck{}, invalid_attrs)
    refute changeset.valid?
  end
end
