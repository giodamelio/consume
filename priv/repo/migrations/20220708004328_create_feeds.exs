defmodule Consume.Repo.Migrations.CreateFeeds do
  use Ecto.Migration

  def change do
    create table(:feeds) do
      add :name, :string
      add :type, :string
      add :url, :string
      add :fetched_at, :utc_datetime
      add :fetch_frequency_seconds, :integer

      timestamps()
    end
  end
end
