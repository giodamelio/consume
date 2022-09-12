defmodule Consume.Repo.Migrations.CreateFeedItems do
  use Ecto.Migration

  def change do
    create table(:feed_items) do
      add :hash, :string, null: false
      add :data, :text, null: false
      add :feed_id, references(:feeds, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:feed_items, [:feed_id])
  end
end
