defmodule Consume.Fetcher.FetchesData do
  use Ecto.Schema
  import Ecto.Changeset

  schema "fetches_data" do
    field :data, :binary
    field :hash, :string

    timestamps()
  end

  @doc false
  def changeset(fetches_data, attrs) do
    fetches_data
    |> cast(attrs, [:hash, :data])
    |> validate_required([:hash, :data])
    |> unique_constraint(:hash)
  end
end
