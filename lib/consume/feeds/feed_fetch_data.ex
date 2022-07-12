defmodule Consume.Feeds.FeedFetchData do
  @moduledoc """
  Content addressable store of fetch data
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "feed_fetch_data" do
    field :data, :binary
    field :sha256, :string
    field :feed_id, :id

    timestamps()
  end

  @doc false
  def changeset(feed_fetch_data, attrs) do
    feed_fetch_data
    |> cast(attrs, [:data, :sha256])
    |> validate_required([:data, :sha256])
  end
end
