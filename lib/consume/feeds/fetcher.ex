defmodule Consume.Feeds.Fetcher do
  use GenServer

  ## Client API

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts ++ [name: __MODULE__])
  end

  def hello(name) do
    GenServer.call(__MODULE__, {:hello, name})
  end

  ## GenServer callbacks

  def handle_call({:hello, name}, _from, state) do
    {:reply, "Hello #{name}!", state}
  end

  def init(args) do
    {:ok, args}
  end
end
