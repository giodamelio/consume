defmodule Consume.Repo.Migrations.FeedFetchRemoveDataAddReference do
  use Ecto.Migration

  def change do
    alter table("feed_fetches") do
      remove :sha256
      remove :data

      add :feed_fetch_data_id, references("feed_fetch_data")
    end
  end
end
