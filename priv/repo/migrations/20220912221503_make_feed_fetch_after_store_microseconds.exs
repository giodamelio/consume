defmodule Consume.Repo.Migrations.MakeFeedFetchAfterStoreMicroseconds do
  use Ecto.Migration

  def change do
    alter table(:feeds) do
      modify :fetch_after, :utc_datetime_usec, null: false
    end
  end
end
