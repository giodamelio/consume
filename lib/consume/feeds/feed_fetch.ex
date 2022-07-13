defmodule Consume.Feeds.FeedFetch do
  @moduledoc """
  Keeps track of all our feeds
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "feed_fetches" do
    field :feed_id, :id
    field :feed_fetch_data_id, :id

    timestamps()
  end

  @doc false
  def changeset(feed_fetch, attrs) do
    feed_fetch
    |> cast(attrs, [:feed_id, :feed_fetch_data_id])
    |> validate_required([:feed_id, :feed_fetch_data_id])
    |> foreign_key_constraint(:feed_id)
    |> foreign_key_constraint(:feed_fetch_data_id)
  end
end
