defmodule Consume.Fetcher.FetcherTest do
  use ExUnit.Case

  alias Consume.Fetcher.Fetcher

  def fetcher_modules do
    with {:ok, all_modules} <- :application.get_key(:consume, :modules) do
      all_modules
      |> Enum.filter(fn m ->
        case Module.split(m) do
          ["Consume", "Fetcher", "Fetchers", name] -> name
          _ -> false
        end
      end)
    end
  end

  # Read the registered modules to ensure that the list_fetchers/0 is kept up to date when new fetchers are added
  test "properly lists the available fetchers" do
    assert length(Fetcher.list_fetchers()) == length(fetcher_modules())
  end

  test "can get fetcher by name" do
    for fetcher <- fetcher_modules() do
      assert Fetcher.get_fetcher(fetcher.name()) == {:ok, fetcher}
    end
  end

  defmodule ConstantFetcher do
    @behaviour Consume.Fetcher.Fetcher

    @impl true
    def name(), do: "constant"

    @impl true
    def fetch(_uri) do
      data = "Hello World!"
      hash = :crypto.hash(:sha256, data)
      item = %{version: 1, hash: hash, data: data}

      {:ok, [item]}
    end

    @impl true
    def valid_id?(_uri) do
      true
    end
  end

  test "correctly implements Consume.Fetcher.fetch" do
    {:ok, [%{hash: hash, data: data}]} = ConstantFetcher.fetch("Not important")

    assert data == "Hello World!"

    assert hash ==
             <<127, 131, 177, 101, 127, 241, 252, 83, 185, 45, 193, 129, 72, 161, 214, 93, 252,
               45, 75, 31, 163, 214, 119, 40, 74, 221, 210, 0, 18, 109, 144, 105>>
  end

  test "correctly implements Consume.Fetcher.valid_id?" do
    assert ConstantFetcher.valid_id?("Not important") == true
  end
end
