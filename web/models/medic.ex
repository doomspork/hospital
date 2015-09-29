defmodule Hospital.Medic do
  use Hospital.Web, :model

  schema "medics" do
    field :name, :string
    field :tags, {:array, :string}, default: []

    timestamps
  end

  @required_fields ~w(name)
  @optional_fields ~w(tags)

  def create_changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
