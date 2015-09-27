defmodule Hospital.HealthCheck do
  use Hospital.Web, :model

  schema "health_checks" do
    field :name, :string, null: false
    field :options, :map, default: %{}
    field :regions, {:array, :string}, default: ["*"]
    field :target, :string, null: false
    field :type, :string, null: false

    belongs_to :user, Hospital.User

    timestamps
  end

  @support_types ~w(ping get)

  def create_changeset(model), do: model |> cast(%{}, ~w(), ~w(name options regions target type))
  def create_changeset(model, params) do
    model
    |> cast(params, ~w(name target type user_id), ~w(regions options))
    |> validate_inclusion(:type, @support_types)
    |> unique_constraint(:name_by_user)
  end
end
