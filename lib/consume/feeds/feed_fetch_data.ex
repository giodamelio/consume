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
    |> cast(attrs, [:data, :feed_id])
    |> validate_required([:data, :feed_id])
    |> foreign_key_constraint(:feed_id)
    |> hash_data()
  end

  defp hash_data(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{data: data}} ->
        hash =
          :crypto.hash(:sha256, data)
          |> Base.encode16()

        put_change(changeset, :sha256, hash)

      _ ->
        changeset
    end
  end
end
