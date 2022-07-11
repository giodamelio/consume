defmodule Consume.Repo.Migrations.FeedsAddEnabledColumn do
  use Ecto.Migration

  def change do
    alter table("feeds") do
      add :enabled, :boolean, null: false, default: false
    end
  end
end
