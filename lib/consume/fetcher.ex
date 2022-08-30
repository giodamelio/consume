defmodule Consume.Fetcher do
  @moduledoc """
  Describe a simple Fetcher.
  """

  @typedoc """
  A sha256 hash
  """
  @type hash :: binary()

  @typedoc """
  A URI
  """
  @type uri :: binary()

  @doc """
  Fetches a resource and returns the binary representation of it alongside it's hash.
  """
  @callback fetch(uri) :: {:ok, {hash, binary()}} | {:error, String.t()}

  @doc """
  Validates that the uri is valid for this fetcher.
  """
  @callback valid_id?(uri) :: boolean()
end