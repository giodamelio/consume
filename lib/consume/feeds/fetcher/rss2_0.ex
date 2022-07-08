defmodule Consume.Feeds.Fetcher.Rss20 do
  alias Consume.Feeds

  def fetch(_feed_id, _url) do
    nil
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
