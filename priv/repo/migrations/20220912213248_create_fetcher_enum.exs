defmodule Consume.Repo.Migrations.CreateFetcherEnum do
  use Ecto.Migration

  def change do
    execute(
      """
      CREATE TYPE fetcher AS ENUM (
        'rss2_0',
        'atom',
        'youtube'
      )
      """,
      "DROP TYPE fetcher"
    )
  end
end
