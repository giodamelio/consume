defmodule Consume.Feeds.FetcherTest do
  use ExUnit.Case, async: true

  alias Consume.Feeds.Fetcher

  setup do
    {:ok, _pid} = start_supervised(Fetcher)
    :ok
  end

  test "says hello" do
    assert Fetcher.hello("Gio") == "Hello Gio!"
  end
end
