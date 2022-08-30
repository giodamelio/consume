defmodule Consume.Repo.Migrations.CreateRawFetchData do
  use Ecto.Migration

  def change do
    create table(:raw_fetch_data) do
      add :hash, :string
      add :data, :binary

      timestamps()
    end
  end
end
