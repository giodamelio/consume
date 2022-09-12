defmodule Consume.Fetcher.Feed do
  use Ecto.Schema
  import Ecto.Changeset

  schema "feeds" do
    field :fetch_after, :utc_datetime
    field :fetch_interval_seconds, :integer
    field :fetcher, Ecto.Enum, values: [:rss2_0, :atom, :youtube]
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(feed, attrs) do
    feed
    |> cast(attrs, [:name, :fetcher, :fetch_after, :fetch_interval_seconds])
    |> validate_required([:name, :fetcher, :fetch_after, :fetch_interval_seconds])
  end
end
