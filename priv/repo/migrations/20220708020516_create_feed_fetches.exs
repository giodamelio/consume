defmodule Consume.Repo.Migrations.CreateFeedFetches do
  use Ecto.Migration

  def change do
    create table(:feed_fetches) do
      add :sha256, :string
      add :data, :binary
      add :feed_id, references(:feeds, on_delete: :nothing)

      timestamps()
    end

    create index(:feed_fetches, [:feed_id])
  end
end
