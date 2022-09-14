defmodule Consume.Fetcher.Fetcher do
  @moduledoc """
  Describe a simple Fetcher.
  """

  @typedoc """
  A sha256 hash
  """
  @type hash :: binary()

  @typedoc """
  The Data for a feed item
  """
  @type data :: binary()

  @typedoc """
  A FeedItem
  """
  @type feed_item :: %{version: integer(), hash: hash, data: data}

  @typedoc """
  A URI
  """
  @type uri :: String.t()

  @doc """
  Returns a string representation of the fetchers name.
  """
  @callback name() :: String.t()

  @doc """
  Fetches a resource and returns the binary representation of it alongside it's hash.
  """
  @callback fetch(uri) :: {:ok, list(feed_item)} | {:error, String.t()}

  @doc """
  Validates that the uri is valid for this fetcher.
  """
  @callback valid_id?(uri) :: boolean()

  def list_fetchers() do
    [Consume.Fetcher.Fetchers.RSS2_0Fetcher]
  end

  def get_fetcher("rss2_0"), do: {:ok, Consume.Fetcher.Fetchers.RSS2_0Fetcher}
  def get_fetcher(name), do: {:error, "Fetcher #{name} not found"}
end
