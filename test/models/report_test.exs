defmodule Hospital.ReportTest do
  use Hospital.ModelCase

  alias Hospital.Report

  @valid_attrs %{successful: true, medic_id: 1, health_check_id: 10, results: %{}}
  @invalid_attrs %{}

  test "create changeset with valid attributes" do
    changeset = Report.create_changeset(%Report{}, @valid_attrs)
    assert changeset.valid?
  end

  test "create changeset with invalid attributes" do
    changeset = Report.create_changeset(%Report{}, @invalid_attrs)
    refute changeset.valid?
  end
end
