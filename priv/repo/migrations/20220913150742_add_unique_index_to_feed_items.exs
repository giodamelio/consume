defmodule Consume.Repo.Migrations.AddUniqueIndexToFeedItems do
  use Ecto.Migration

  def change do
    create index(:feed_items, [:feed_id, :hash], unique: true)
  end
end
