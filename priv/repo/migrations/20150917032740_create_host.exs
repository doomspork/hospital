defmodule Hospital.Repo.Migrations.CreateHost do
  use Ecto.Migration

  def change do
    create table(:hosts) do
      add :address, :string

      timestamps
    end

  end
end
