defmodule Consume.Repo.Migrations.CreateFeedFetchData do
  use Ecto.Migration

  def change do
    create table(:feed_fetch_data) do
      add :data, :binary
      add :sha256, :string
      add :feed_id, references(:feeds, on_delete: :nothing)

      timestamps()
    end

    create index(:feed_fetch_data, [:feed_id])
  end
end
