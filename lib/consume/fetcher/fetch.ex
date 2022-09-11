defmodule Consume.Fetcher.Fetch do
  use Ecto.Schema
  import Ecto.Changeset

  schema "fetches" do
    field :fetched_at, :utc_datetime
    field :fetches_data_id, :id

    timestamps()
  end

  @doc false
  def changeset(fetch, attrs) do
    fetch
    |> cast(attrs, [:fetched_at, :fetches_data_id])
    |> validate_required([:fetched_at, :fetches_data_id])
    |> foreign_key_constraint(:fetches_data_id)
  end
end
