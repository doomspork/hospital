defmodule Hospital.Repo.Migrations.CreateHealthCheck do
  use Ecto.Migration

  def change do
    create table(:health_checks) do
      add :name, :string
      add :options, :map
      add :regions, {:array, :string}, default: []
      add :target, :string
      add :type, :string
      add :user_id, references(:users)

      timestamps
    end

    create unique_index(:health_checks, [:name, :user_id], name: :name_by_user)
  end
end
