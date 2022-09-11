defmodule Consume.Repo.Migrations.AddNotNullEverywhere do
  use Ecto.Migration

  def change do
    alter table(:fetches_data) do
      modify :hash, :string, null: false
      modify :data, :binary, null: false
    end

    alter table(:fetches) do
      modify :fetched_at, :utc_datetime, null: false

      modify :fetches_data_id, references(:fetches_data, on_delete: :nothing),
        null: false,
        from: references(:fetches_data, on_delete: :nothing)
    end
  end
end
