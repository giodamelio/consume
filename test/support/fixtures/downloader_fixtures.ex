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
end
