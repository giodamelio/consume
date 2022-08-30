defmodule Consume.Fetcher.HttpGetFetcherTest do
  use ExUnit.Case

  alias Consume.Fetcher.HttpGetFetcher
  import Tesla.Mock

  test "correctly implements Consume.Fetcher.name" do
    assert HttpGetFetcher.name() == "http_get"
  end

  test "can get fetcher by name" do
    assert Consume.Fetcher.get_fetcher("http_get") == {:ok, HttpGetFetcher}
  end

  test "correctly implements Consume.Fetcher.fetch" do
    mock(fn _req ->
      %Tesla.Env{
        status: 200,
        body: "{}"
      }
    end)

    {:ok, {hash, data}} = HttpGetFetcher.fetch("https://httpbin.org/get")

    assert data == "{}"

    assert hash ==
             <<68, 19, 111, 163, 85, 179, 103, 138, 17, 70, 173, 22, 247, 232, 100, 158, 148, 251,
               79, 194, 31, 231, 126, 131, 16, 192, 96, 246, 28, 170, 255, 138>>
  end

  test "correctly implements Consume.Fetcher.valid_id?" do
    assert HttpGetFetcher.valid_id?("https://httpbin.org/get") == true
    assert HttpGetFetcher.valid_id?("http://httpbin.org/get") == true

    assert HttpGetFetcher.valid_id?("not_a_http_or_https_url") == false
  end
end
