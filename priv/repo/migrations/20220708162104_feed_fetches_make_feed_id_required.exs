defmodule Consume.Repo.Migrations.FeedFetchesMakeFeedIdRequired do
  use Ecto.Migration

  def change do
    execute(&execute_up/0, &execute_down/0)
  end

  defp execute_up,
    do:
      repo().query!("ALTER TABLE feed_fetches ALTER COLUMN feed_id SET NOT NULL", [], log: :info)

  defp execute_down,
    do:
      repo().query!("ALTER TABLE feed_fetches ALTER COLUMN feed_id DROP NOT NULL", [], log: :info)
end
