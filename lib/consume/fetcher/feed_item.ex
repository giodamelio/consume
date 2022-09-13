defmodule Consume.Fetcher.FeedItem do
  use Ecto.Schema
  import Ecto.Changeset

  schema "feed_items" do
    field :data, :string
    field :hash, :string
    field :feed_id, :id

    timestamps()
  end

  @doc false
  def changeset(feed_item, attrs) do
    feed_item
    |> cast(attrs, [:hash, :data, :feed_id])
    |> validate_required([:hash, :data, :feed_id])
    |> foreign_key_constraint(:feed_id)
    |> unique_constraint([:feed_id, :hash])
  end
end
