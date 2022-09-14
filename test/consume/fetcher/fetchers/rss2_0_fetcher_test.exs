defmodule Consume.Fetcher.Fetchers.RSS2_0FetcherTest do
  use ExUnit.Case

  alias Consume.Fetcher.Fetchers.RSS2_0Fetcher
  import Tesla.Mock

  test "correctly implements Consume.Fetcher.name" do
    assert RSS2_0Fetcher.name() == "rss2_0"
  end

  test "can get fetcher by name" do
    assert Consume.Fetcher.Fetcher.get_fetcher("rss2_0") == {:ok, RSS2_0Fetcher}
  end

  test "correctly implements Consume.Fetcher.fetch" do
    mock(fn _req ->
      %Tesla.Env{
        status: 200,
        body:
          File.read!(Path.expand("../../../support/fixtures/fetchers/breaking_news.rss", __DIR__))
      }
    end)

    {:ok, feed} = RSS2_0Fetcher.fetch("https://fake.feed/url.rss")

    assert length(feed) == 10

    assert Enum.at(feed, 0)[:hash] ==
             <<172, 133, 149, 37, 80, 250, 238, 23, 199, 31, 75, 161, 53, 249, 79, 61, 229, 126,
               72, 182, 255, 172, 23, 175, 211, 250, 149, 153, 212, 135, 218, 102>>

    assert Enum.at(feed, 9)[:hash] ==
             <<235, 134, 33, 124, 236, 213, 117, 142, 136, 95, 161, 109, 72, 134, 89, 127, 138,
               68, 116, 222, 117, 207, 173, 32, 167, 217, 239, 64, 154, 148, 204, 228>>
  end

  test "correctly implements Consume.Fetcher.valid_id?" do
    assert RSS2_0Fetcher.valid_id?("https://httpbin.org/get") == true
    assert RSS2_0Fetcher.valid_id?("http://httpbin.org/get") == true

    assert RSS2_0Fetcher.valid_id?("not_a_http_or_https_url") == false
  end
end
