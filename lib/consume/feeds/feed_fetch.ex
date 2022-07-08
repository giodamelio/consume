defmodule Consume.Feeds.FeedFetch do
  use Ecto.Schema
  import Ecto.Changeset

  schema "feed_fetches" do
    field :data, :binary
    field :sha256, :string
    field :feed_id, :id

    timestamps()
  end

  @doc false
  def changeset(feed_fetch, attrs) do
    feed_fetch
    |> cast(attrs, [:sha256, :data, :feed_id])
    |> validate_required([:sha256, :data])
    |> foreign_key_constraint(:feed_id)
  end
end
