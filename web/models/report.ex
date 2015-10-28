defmodule Hospital.Report do
  use Hospital.Web, :model

  schema "reports" do
    field :checked_at, Ecto.DateTime, default: Ecto.DateTime.utc
    field :successful, :boolean, default: false
    field :response_time, :float

    belongs_to :health_check, Hospital.HealthCheck
    belongs_to :medic, Hospital.Medic

    timestamps
  end

  @required_fields ~w(successful response_time medic_id health_check_id)
  @optional_fields ~w(checked_at)

  def create_changeset(model, params \\ :empty) do
    # Remove if nil so a default is set
    unless params["checked_at"] do
      params = Map.delete(params, "checked_at")
    end

    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
