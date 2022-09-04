defmodule Consume.DownloaderTest do
  use Consume.DataCase

  alias Consume.Downloader

  describe "raw_fetch_data" do
    alias Consume.Downloader.RawFetchData

    import Consume.DownloaderFixtures

    @invalid_attrs %{data: nil, hash: nil}

    test "list_raw_fetch_data/0 returns all raw_fetch_data" do
      raw_fetch_data = raw_fetch_data_fixture()
      assert Downloader.list_raw_fetch_data() == [raw_fetch_data]
    end

    test "get_raw_fetch_data!/1 returns the raw_fetch_data with given id" do
      raw_fetch_data = raw_fetch_data_fixture()
      assert Downloader.get_raw_fetch_data!(raw_fetch_data.id) == raw_fetch_data
    end

    test "create_raw_fetch_data/1 with valid data creates a raw_fetch_data" do
      valid_attrs = %{data: "some data", hash: "some hash"}

      assert {:ok, %RawFetchData{} = raw_fetch_data} =
               Downloader.create_raw_fetch_data(valid_attrs)

      assert raw_fetch_data.data == "some data"
      assert raw_fetch_data.hash == "some hash"
    end

    test "create_raw_fetch_data/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Downloader.create_raw_fetch_data(@invalid_attrs)
    end

    test "update_raw_fetch_data/2 with valid data updates the raw_fetch_data" do
      raw_fetch_data = raw_fetch_data_fixture()
      update_attrs = %{data: "some updated data", hash: "some updated hash"}

      assert {:ok, %RawFetchData{} = raw_fetch_data} =
               Downloader.update_raw_fetch_data(raw_fetch_data, update_attrs)

      assert raw_fetch_data.data == "some updated data"
      assert raw_fetch_data.hash == "some updated hash"
    end

    test "update_raw_fetch_data/2 with invalid data returns error changeset" do
      raw_fetch_data = raw_fetch_data_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Downloader.update_raw_fetch_data(raw_fetch_data, @invalid_attrs)

      assert raw_fetch_data == Downloader.get_raw_fetch_data!(raw_fetch_data.id)
    end

    test "delete_raw_fetch_data/1 deletes the raw_fetch_data" do
      raw_fetch_data = raw_fetch_data_fixture()
      assert {:ok, %RawFetchData{}} = Downloader.delete_raw_fetch_data(raw_fetch_data)

      assert_raise Ecto.NoResultsError, fn ->
        Downloader.get_raw_fetch_data!(raw_fetch_data.id)
      end
    end

    test "change_raw_fetch_data/1 returns a raw_fetch_data changeset" do
      raw_fetch_data = raw_fetch_data_fixture()
      assert %Ecto.Changeset{} = Downloader.change_raw_fetch_data(raw_fetch_data)
    end
  end

  describe "fetches" do
    alias Consume.Downloader.Fetch

    import Consume.DownloaderFixtures

    @invalid_attrs %{fetched_at: nil}

    test "list_fetches/0 returns all fetches" do
      fetch = fetch_fixture()
      assert Downloader.list_fetches() == [fetch]
    end

    test "get_fetch!/1 returns the fetch with given id" do
      fetch = fetch_fixture()
      assert Downloader.get_fetch!(fetch.id) == fetch
    end

    test "create_fetch/1 with valid data creates a fetch" do
      raw_fetch_data = raw_fetch_data_fixture()
      valid_attrs = %{fetched_at: ~U[2022-09-03 00:34:00Z], raw_fetch_data_id: raw_fetch_data.id}

      assert {:ok, %Fetch{} = fetch} = Downloader.create_fetch(valid_attrs)
      assert fetch.fetched_at == ~U[2022-09-03 00:34:00Z]
    end

    test "create_fetch/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Downloader.create_fetch(@invalid_attrs)
    end

    test "update_fetch/2 with valid data updates the fetch" do
      fetch = fetch_fixture()
      update_attrs = %{fetched_at: ~U[2022-09-04 00:34:00Z]}

      assert {:ok, %Fetch{} = fetch} = Downloader.update_fetch(fetch, update_attrs)
      assert fetch.fetched_at == ~U[2022-09-04 00:34:00Z]
    end

    test "update_fetch/2 with invalid data returns error changeset" do
      fetch = fetch_fixture()
      assert {:error, %Ecto.Changeset{}} = Downloader.update_fetch(fetch, @invalid_attrs)
      assert fetch == Downloader.get_fetch!(fetch.id)
    end

    test "delete_fetch/1 deletes the fetch" do
      fetch = fetch_fixture()
      assert {:ok, %Fetch{}} = Downloader.delete_fetch(fetch)
      assert_raise Ecto.NoResultsError, fn -> Downloader.get_fetch!(fetch.id) end
    end

    test "change_fetch/1 returns a fetch changeset" do
      fetch = fetch_fixture()
      assert %Ecto.Changeset{} = Downloader.change_fetch(fetch)
    end
  end
end
