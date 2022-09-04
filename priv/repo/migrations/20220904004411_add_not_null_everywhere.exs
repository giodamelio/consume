defmodule Consume.Repo.Migrations.AddNotNullEverywhere do
  use Ecto.Migration

  def change do
    alter table(:raw_fetch_data) do
      modify :hash, :string, null: false
      modify :data, :binary, null: false
    end

    alter table(:fetches) do
      modify :fetched_at, :utc_datetime, null: false

      modify :raw_fetch_data_id, references(:raw_fetch_data, on_delete: :nothing),
        null: false,
        from: references(:raw_fetch_data, on_delete: :nothing)
    end
  end
end
