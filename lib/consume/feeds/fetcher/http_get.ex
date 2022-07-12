defmodule Consume.Feeds.Fetcher.HTTPGet do
  @moduledoc """
  Simple fetcher that makes a GET request to the feeds url
  """

  alias Consume.Feeds

  def fetch(%Feeds.Feed{} = feed) do
    with {:ok, response} <- request(feed.url),
         {:ok, changes} <- save_fetch(feed, response.body) do
      {:ok, changes}
    else
      err ->
        {:error, err}
    end
  end

  def request(url) do
    HTTPoison.get(url)
  end

  def save_fetch(feed, data) do
    Feeds.update_feed(feed, %{
      fetch_after: DateTime.now!("Etc/UTC") |> DateTime.add(feed.fetch_frequency_seconds, :second)
    })

    Feeds.create_feed_fetch(%{
      feed_id: feed.id,
      data: data
    })
  end
end
