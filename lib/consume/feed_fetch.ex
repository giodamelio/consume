defmodule Consume.FeedFetch do
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
    |> cast(attrs, [:sha256, :data])
    |> validate_required([:sha256, :data])
  end
end
