defmodule Hospital.Repo.Migrations.CreateMedic do
  use Ecto.Migration

  def change do
    create table(:medics) do
      add :name, :string
      add :tags, {:array, :string}, default: []

      timestamps
    end

  end
end
