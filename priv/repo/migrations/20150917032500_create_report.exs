defmodule Hospital.Repo.Migrations.CreateReport do
  use Ecto.Migration

  def change do
    create table(:reports) do
      add :successful, :boolean
      add :results, :map
      add :health_check_id, references(:health_checks)

      timestamps
    end

  end
end
