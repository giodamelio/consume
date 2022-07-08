defmodule Consume.Feeds.Feed do
  use Ecto.Schema
  import Ecto.Changeset

  schema "feeds" do
    field :fetch_frequency_seconds, :integer
    field :fetched_at, :utc_datetime
    field :name, :string
    field :type, Ecto.Enum, values: [:rss2_0, :atom, :jsonfeed]
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(feed, attrs) do
    feed
    |> cast(attrs, [:name, :type, :url, :fetched_at, :fetch_frequency_seconds])
    |> validate_required([:name, :type, :url, :fetched_at, :fetch_frequency_seconds])
  end
end
