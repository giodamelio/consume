defmodule Consume.Feeds.FetcherTest do
  use ExUnit.Case, async: true

  alias Consume.Feeds.Fetcher

  setup do
    {:ok, pid} = start_supervised(Fetcher)
    %{pid: pid}
  end

  test "doesn't tick if we don't enable it", %{pid: pid} do
    Process.sleep(2500)
    assert :sys.get_state(pid).ticks_since_started == 0
  end

  test "tick two times if we wait", %{pid: pid} do
    :enabled = Fetcher.enable()
    Process.sleep(2500)
    :disabled = Fetcher.disable()

    assert :sys.get_state(pid).ticks_since_started == 2
  end
end
