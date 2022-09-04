defmodule Consume.DownloaderFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Consume.Downloader` context.
  """

  @doc """
  Generate a raw_fetch_data.
  """
  def raw_fetch_data_fixture(attrs \\ %{}) do
    {:ok, raw_fetch_data} =
      attrs
      |> Enum.into(%{
        data: "some data",
        hash: "some hash"
      })
      |> Consume.Downloader.create_raw_fetch_data()

    raw_fetch_data
  end

  @doc """
  Generate a fetch.
  """
  def fetch_fixture(attrs \\ %{}) do
    {:ok, fetch} =
      attrs
      |> Enum.into(%{
        fetched_at: ~U[2022-09-03 00:34:00Z]
      })
      |> Consume.Downloader.create_fetch()

    fetch
  end
end
