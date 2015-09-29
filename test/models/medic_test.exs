defmodule Hospital.MedicTest do
  use Hospital.ModelCase

  alias Hospital.Medic

  @valid_attrs %{name: "some content", tags: ["some", "tags"]}
  @invalid_attrs %{}

  test "create changeset with valid attributes" do
    changeset = Medic.create_changeset(%Medic{}, @valid_attrs)
    assert changeset.valid?
  end

  test "create changeset with invalid attributes" do
    changeset = Medic.create_changeset(%Medic{}, @invalid_attrs)
    refute changeset.valid?
  end
end
