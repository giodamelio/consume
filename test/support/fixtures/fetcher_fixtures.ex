defmodule Consume.FetcherFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Consume.Fetcher` context.
  """

  @doc """
  Generate a fetches_data.
  """
  def fetches_data_fixture(attrs \\ %{}) do
    {:ok, fetches_data} =
      attrs
      |> Enum.into(%{
        data: "some data",
        hash: :crypto.strong_rand_bytes(32) |> Base.encode64()
      })
      |> Consume.Fetcher.create_fetches_data()

    fetches_data
  end

  @doc """
  Generate a fetch.
  """
  def fetch_fixture(attrs \\ %{}) do
    fetches_data = fetches_data_fixture()

    {:ok, fetch} =
      attrs
      |> Enum.into(%{
        fetched_at: ~U[2022-09-03 00:34:00Z],
        fetches_data_id: fetches_data.id
      })
      |> Consume.Fetcher.create_fetch()

    fetch
  end

  @doc """
  Generate a feed.
  """
  def feed_fixture(attrs \\ %{}) do
    {:ok, feed} =
      attrs
      |> Enum.into(%{
        fetch_after: ~U[2022-09-11 21:50:00Z],
        fetch_interval_seconds: 42,
        fetcher: :rss2_0,
        name: "some name",
        uri: "https://nope.nop"
      })
      |> Consume.Fetcher.create_feed()

    feed
  end
end
