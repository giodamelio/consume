defmodule Consume.Repo.Migrations.FeedsRenameFetchedAtToFetchAfter do
  use Ecto.Migration

  def change do
    rename table("feeds"), :fetched_at, to: :fetch_after
  end
end
