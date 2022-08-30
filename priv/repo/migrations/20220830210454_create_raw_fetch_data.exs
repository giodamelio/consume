defmodule Consume.Repo.Migrations.CreateRawFetchData do
  use Ecto.Migration

  def change do
    create table(:raw_fetch_data) do
      add :hash, :string
      add :data, :binary

      timestamps()
    end

    create unique_index(:raw_fetch_data, [:hash])
  end
end
