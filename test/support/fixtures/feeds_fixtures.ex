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
        fetched_at: ~U[2022-07-07 02:04:00Z],
        name: "some name",
        type: :rss2_0,
        url: "some url"
      })
      |> Consume.Feeds.create_feed()

    feed
  end

  @doc """
  Generate a feed_fetch.
  """
  def feed_fetch_fixture(attrs \\ %{}) do
    {:ok, feed_fetch} =
      attrs
      |> Enum.into(%{
        data: "some data",
        sha256: "some sha256"
      })
      |> Consume.Feeds.create_feed_fetch()

    feed_fetch
  end
end
