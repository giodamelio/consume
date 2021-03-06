defmodule Consume.FeedsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Consume.Feeds` context.
  """

  @doc """
  Generate a feed.
  """
  def feed_fixture(attrs \\ %{}) do
    {:ok, feed} =
      attrs
      |> Enum.into(%{
        fetch_frequency_seconds: 42,
        fetch_after: ~U[2022-07-07 02:04:00Z],
        name: "some name",
        fetcher: :http_get,
        parser: :rss2_0,
        url: "some url",
        enabled: false
      })
      |> Consume.Feeds.create_feed()

    feed
  end

  @doc """
  Generate a feed_fetch.
  """
  def feed_fetch_fixture(attrs \\ %{}) do
    feed = feed_fixture()
    feed_fetch_data = feed_fetch_data_fixture()

    {:ok, feed_fetch} =
      attrs
      |> Enum.into(%{
        feed_id: feed.id,
        feed_fetch_data_id: feed_fetch_data.id
      })
      |> Consume.Feeds.create_feed_fetch()

    feed_fetch
  end

  @doc """
  Generate a feed_fetch_data.
  """
  def feed_fetch_data_fixture(attrs \\ %{}) do
    feed = feed_fixture()

    {:ok, feed_fetch_data} =
      attrs
      |> Enum.into(%{
        data: "some data",
        feed_id: feed.id
      })
      |> Consume.Feeds.create_feed_fetch_data()

    feed_fetch_data
  end
end
