defmodule Consume.Repo.Migrations.CreateFetches do
  use Ecto.Migration

  def change do
    create table(:fetches) do
      add :fetched_at, :utc_datetime
      add :raw_fetch_data_id, references(:raw_fetch_data, on_delete: :nothing)

      timestamps()
    end

    create index(:fetches, [:raw_fetch_data_id])
  end
end
