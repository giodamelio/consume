defmodule Consume.FetcherFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Consume.Fetcher` context.
  """

  @doc """
  Generate a raw_fetch_data.
  """
  def raw_fetch_data_fixture(attrs \\ %{}) do
    {:ok, raw_fetch_data} =
      attrs
      |> Enum.into(%{
        data: "some data",
        hash: :crypto.strong_rand_bytes(32) |> Base.encode64()
      })
      |> Consume.Fetcher.create_raw_fetch_data()

    raw_fetch_data
  end

  @doc """
  Generate a fetch.
  """
  def fetch_fixture(attrs \\ %{}) do
    raw_fetch_data = raw_fetch_data_fixture()

    {:ok, fetch} =
      attrs
      |> Enum.into(%{
        fetched_at: ~U[2022-09-03 00:34:00Z],
        raw_fetch_data_id: raw_fetch_data.id
      })
      |> Consume.Fetcher.create_fetch()

    fetch
  end
end
