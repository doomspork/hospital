defmodule Hospital.UserTest do
  use Hospital.ModelCase

  alias Hospital.User

  @valid_attrs %{email: "user@example.com",
                 password: "a hard password",
                 password_confirmation: "a hard password",
                 name: "Test User"}

  @invalid_attrs Map.delete(@valid_attrs, :password_confirmation)

  test "create changeset with valid attributes" do
    changeset = User.create_changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "create changeset with invalid attributes" do
    changeset = User.create_changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
