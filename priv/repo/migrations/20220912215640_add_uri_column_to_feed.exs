defmodule Consume.Repo.Migrations.AddUriColumnToFeed do
  use Ecto.Migration

  def change do
    alter table(:feeds) do
      add :uri, :string, null: false
    end
  end
end
