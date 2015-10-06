defmodule Hospital.Repo.Migrations.CreateInitialTables do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string, unique: true
      add :encrypted_password, :string

      timestamps
    end

    create unique_index(:users, [:email], name: :email)

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

    create table(:medics) do
      add :name, :string
      add :tags, {:array, :string}, default: []

      timestamps
    end

    create table(:reports) do
      add :health_check_id, references(:health_checks)
      add :medic_id, references(:medics)
      add :response_time, :float
      add :successful, :boolean

      timestamps
    end

  end
end
