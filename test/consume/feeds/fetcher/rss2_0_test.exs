defmodule Consume.Feeds.Fetcher.Rss20Test do
  use ExUnit.Case
  use Consume.DataCase

  alias Consume.Feeds
  alias Consume.Feeds.Fetcher.Rss20

  describe "request/1" do
    test "returns status 200" do
      {:ok, %HTTPoison.Response{status_code: status}} =
        Rss20.request("https://www.nasa.gov/rss/dyn/breaking_news.rss")

      assert status == 200
    end

    test "fails on bad url" do
      {:error, err} = Rss20.request("not_a_url")

      assert err == %HTTPoison.Error{id: nil, reason: :nxdomain}
    end
  end

  describe "save_fetch/2" do
    test "save an example fetch feed" do
      # Create feed to attach the feed fetch to
      {:ok, feed} =
        Feeds.create_feed(%{
          fetch_frequency_seconds: 42,
          fetched_at: ~U[2022-07-07 02:04:00Z],
          name: "some name",
          type: :rss2_0,
          url: "some url"
        })

      {:ok, new_feed_fetch} = Rss20.save_fetch(feed.id, "Hello World!")

      assert new_feed_fetch.feed_id == feed.id
      assert new_feed_fetch.data == "Hello World!"

      assert new_feed_fetch.sha256 ==
               "7F83B1657FF1FC53B92DC18148A1D65DFC2D4B1FA3D677284ADDD200126D9069"
    end
  end
end
