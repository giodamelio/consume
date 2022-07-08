defmodule Consume.Repo.Migrations.FeedsRenameTypeToFetcherAddParser do
  use Ecto.Migration

  def change do
    alter table("feeds") do
      add :fetcher, :string, null: false
    end

    rename table("feeds"), :type, to: :parser
  end
end
