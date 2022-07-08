defmodule Consume.Feeds.Fetcher.HTTPGetTest do
  use ExUnit.Case
  use Consume.DataCase

  import Consume.FeedsFixtures

  alias Consume.Feeds.Fetcher.HTTPGet

  @example_feed_url "https://www.nasa.gov/rss/dyn/breaking_news.rss"

  describe "fetch/1" do
    test "fetches and saves an example feed" do
      feed = feed_fixture(url: @example_feed_url)
      {:ok, fetch} = HTTPGet.fetch(feed)

      assert fetch != nil
    end
  end

  describe "request/1" do
    test "returns status 200" do
      {:ok, %HTTPoison.Response{status_code: status}} = HTTPGet.request(@example_feed_url)

      assert status == 200
    end

    test "fails on bad url" do
      {:error, err} = HTTPGet.request("not_a_url")

      assert err == %HTTPoison.Error{id: nil, reason: :nxdomain}
    end
  end

  describe "save_fetch/2" do
    test "save an example fetch feed" do
      feed = feed_fixture()
      {:ok, new_feed_fetch} = HTTPGet.save_fetch(feed.id, "Hello World!")

      assert new_feed_fetch.feed_id == feed.id
      assert new_feed_fetch.data == "Hello World!"

      assert new_feed_fetch.sha256 ==
               "7F83B1657FF1FC53B92DC18148A1D65DFC2D4B1FA3D677284ADDD200126D9069"
    end
  end
end
