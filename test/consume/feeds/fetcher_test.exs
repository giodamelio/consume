defmodule Consume.Feeds.FetcherTest do
  use ExUnit.Case, async: true

  alias Consume.Feeds.Fetcher

  @tag :slow
  test "doesn't tick if we don't enable it" do
    Process.sleep(2500)
    assert Fetcher.ticks_since_started() == 0
  end

  test "reports the enabled status" do
    assert Fetcher.enabled?() == false
    :enabled = Fetcher.enable()
    assert Fetcher.enabled?() == true
    :disabled = Fetcher.disable()
    assert Fetcher.enabled?() == false
  end
end
