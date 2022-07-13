defmodule Consume.Repo.Migrations.FeedFetchDataRemoveDataFromIndex do
  use Ecto.Migration

  def change do
    drop index("feed_fetch_data", [:feed_id, :data, :sha256])
    create unique_index("feed_fetch_data", [:feed_id, :sha256])
  end
end
