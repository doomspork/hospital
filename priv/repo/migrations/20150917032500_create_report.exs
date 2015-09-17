defmodule Hospital.Repo.Migrations.CreateReport do
  use Ecto.Migration

  def change do
    create table(:reports) do
      add :address, :string
      add :type, :string
      add :results, :map

      timestamps
    end

  end
end
