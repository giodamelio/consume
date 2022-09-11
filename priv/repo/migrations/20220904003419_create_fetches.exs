defmodule Consume.Repo.Migrations.CreateFetches do
  use Ecto.Migration

  def change do
    create table(:fetches) do
      add :fetched_at, :utc_datetime
      add :fetches_data_id, references(:fetches_data, on_delete: :nothing)

      timestamps()
    end

    create index(:fetches, [:fetches_data_id])
  end
end
