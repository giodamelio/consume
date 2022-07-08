defmodule Consume.Feeds.Feed do
  use Ecto.Schema
  import Ecto.Changeset

  schema "feeds" do
    field :fetch_frequency_seconds, :integer
    field :fetched_at, :utc_datetime
    field :name, :string
    field :fetcher, Ecto.Enum, values: [:http_get]
    field :parser, Ecto.Enum, values: [:rss2_0, :atom, :jsonfeed, :youtube]
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(feed, attrs) do
    feed
    |> cast(attrs, [:name, :fetcher, :parser, :url, :fetched_at, :fetch_frequency_seconds])
    |> validate_required([:name, :fetcher, :parser, :url, :fetched_at, :fetch_frequency_seconds])
  end
end
