defmodule Consume.Fetcher.RawFetchData do
  use Ecto.Schema
  import Ecto.Changeset

  schema "raw_fetch_data" do
    field :data, :binary
    field :hash, :string

    timestamps()
  end

  @doc false
  def changeset(raw_fetch_data, attrs) do
    raw_fetch_data
    |> cast(attrs, [:hash, :data])
    |> validate_required([:hash, :data])
    |> unique_constraint(:hash)
  end
end
