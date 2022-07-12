defmodule Consume.Feeds.Feed do
  @moduledoc """
  Keeps track of all the times a feed has been fetched
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "feeds" do
    field :fetch_frequency_seconds, :integer
    field :fetch_after, :utc_datetime
    field :name, :string
    field :fetcher, Ecto.Enum, values: [:http_get]
    field :parser, Ecto.Enum, values: [:rss2_0, :atom, :jsonfeed, :youtube]
    field :url, :string
    field :enabled, :boolean

    has_many :feed_fetches, Consume.Feeds.FeedFetch
    has_many :feed_fetch_data, Consume.Feeds.FeedFetchData

    timestamps()
  end

  @doc false
  def changeset(feed, attrs) do
    feed
    |> cast(attrs, [
      :name,
      :fetcher,
      :parser,
      :url,
      :fetch_after,
      :fetch_frequency_seconds,
      :enabled
    ])
    |> validate_required([:name, :fetcher, :parser, :url, :fetch_frequency_seconds, :enabled])
  end

  @doc false
  def delete_changeset(feed) do
    feed
    |> change()
    |> no_assoc_constraint(:feed_fetches)
    |> no_assoc_constraint(:feed_fetch_data)
  end
end
