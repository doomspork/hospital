defmodule Hospital.ReportTest do
  use Hospital.ModelCase

  alias Hospital.Report

  @valid_attrs %{address: "some content", results: %{}, type: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Report.changeset(%Report{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Report.changeset(%Report{}, @invalid_attrs)
    refute changeset.valid?
  end
end
