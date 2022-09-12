defmodule Consume.Repo.Migrations.CreateFeeds do
  use Ecto.Migration

  def change do
    create table(:feeds) do
      add :name, :string
      add :fetcher, :fetcher
      add :fetch_after, :utc_datetime
      add :fetch_interval_seconds, :integer

      timestamps()
    end
  end
end
