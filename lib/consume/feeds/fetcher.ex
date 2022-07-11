defmodule Consume.Feeds.Fetcher do
  use GenServer

  ## Client API

  def start_link(opts \\ []) do
    initial_state = %{
      enabled: false,
      ticks_since_started: 0
    }

    GenServer.start_link(__MODULE__, initial_state, opts ++ [name: __MODULE__])
  end

  def enable() do
    GenServer.call(__MODULE__, {:set_enabled, true})
  end

  def disable() do
    GenServer.call(__MODULE__, {:set_enabled, false})
  end

  ## GenServer callbacks

  def handle_call({:set_enabled, true}, _from, state) do
    timer()
    {:reply, :enabled, %{state | enabled: true}}
  end

  def handle_call({:set_enabled, false}, _from, state) do
    {:reply, :disabled, %{state | enabled: false}}
  end

  # Handles calling the fetcher once a second
  def handle_info(:tick, state) do
    if state.enabled do
      timer()
    end

    {:noreply, %{state | ticks_since_started: state.ticks_since_started + 1}}
  end

  def init(args) do
    {:ok, args}
  end

  # Send a message to self() in 1 second
  defp timer() do
    Process.send_after(self(), :tick, 1_000)
  end
end
