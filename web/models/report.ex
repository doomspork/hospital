defmodule Hospital.Report do
  use Hospital.Web, :model

  schema "reports" do
    field :successful, :boolean, default: false
    field :results, :map

    belongs_to :health_check, Hospital.HealthCheck
    belongs_to :medic, Hospital.Medic

    timestamps
  end

  @required_fields ~w(successful medic_id health_check_id)
  @optional_fields ~w(results)

  def create_changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
