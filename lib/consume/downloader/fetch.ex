defmodule Consume.Downloader.Fetch do
  use Ecto.Schema
  import Ecto.Changeset

  schema "fetches" do
    field :fetched_at, :utc_datetime
    field :raw_fetch_data_id, :id

    timestamps()
  end

  @doc false
  def changeset(fetch, attrs) do
    fetch
    |> cast(attrs, [:fetched_at])
    |> validate_required([:fetched_at])
  end
end
