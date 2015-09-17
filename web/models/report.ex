defmodule Hospital.Report do
  use Hospital.Web, :model

  schema "reports" do
    field :address, :string
    field :type, :string
    field :results, :map

    timestamps
  end

  @required_fields ~w(address type results)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
