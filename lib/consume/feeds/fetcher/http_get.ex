defmodule Consume.Feeds.Fetcher.HTTPGet do
  @moduledoc """
  Simple fetcher that makes a GET request to the feeds url
  """

  alias Consume.Feeds

  def fetch(%Feeds.Feed{} = feed) do
    with {:ok, response} <- request(feed.url),
         {:ok, changes} <- save_fetch(feed.id, response.body) do
      {:ok, changes}
    else
      err ->
        {:error, err}
    end
  end

  def request(url) do
    HTTPoison.get(url)
  end

  def save_fetch(feed_id, data) do
    Feeds.create_feed_fetch(%{
      feed_id: feed_id,
      data: data
    })
  end
end
