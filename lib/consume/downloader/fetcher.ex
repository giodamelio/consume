defmodule Consume.Downloader.Fetcher do
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
  Returns a string representation of the fetchers name.
  """
  @callback name() :: String.t()

  @doc """
  Fetches a resource and returns the binary representation of it alongside it's hash.
  """
  @callback fetch(uri) :: {:ok, {hash, binary()}} | {:error, String.t()}

  @doc """
  Validates that the uri is valid for this fetcher.
  """
  @callback valid_id?(uri) :: boolean()

  def list_fetchers() do
    [Consume.Downloader.Fetchers.HttpGetFetcher]
  end

  def get_fetcher("http_get"), do: {:ok, Consume.Downloader.Fetchers.HttpGetFetcher}
  def get_fetcher(name), do: {:error, "Fetcher #{name} not found"}
end
