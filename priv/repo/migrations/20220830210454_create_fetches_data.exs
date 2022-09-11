defmodule Consume.Repo.Migrations.CreateFetchesData do
  use Ecto.Migration

  def change do
    create table(:fetches_data) do
      add :hash, :string
      add :data, :binary

      timestamps()
    end

    create unique_index(:fetches_data, [:hash])
  end
end
