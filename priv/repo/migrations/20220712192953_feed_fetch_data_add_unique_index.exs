defmodule Consume.Repo.Migrations.FeedFetchDataAddUniqueIndex do
  use Ecto.Migration

  def change do
    create unique_index("feed_fetch_data", [:feed_id, :data, :sha256])
  end
end
