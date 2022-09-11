defmodule Consume.FetcherTest do
  use Consume.DataCase

  alias Consume.Fetcher

  describe "fetches_data" do
    alias Consume.Fetcher.FetchesData

    import Consume.FetcherFixtures

    @invalid_attrs %{data: nil, hash: nil}

    test "list_fetches_data/0 returns all fetches_data" do
      fetches_data = fetches_data_fixture()
      assert Fetcher.list_fetches_data() == [fetches_data]
    end

    test "get_fetches_data!/1 returns the fetches_data with given id" do
      fetches_data = fetches_data_fixture()
      assert Fetcher.get_fetches_data!(fetches_data.id) == fetches_data
    end

    test "create_fetches_data/1 with valid data creates a fetches_data" do
      valid_attrs = %{data: "some data", hash: "some hash"}

      assert {:ok, %FetchesData{} = fetches_data} = Fetcher.create_fetches_data(valid_attrs)

      assert fetches_data.data == "some data"
      assert fetches_data.hash == "some hash"
    end

    test "create_fetches_data/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Fetcher.create_fetches_data(@invalid_attrs)
    end

    test "update_fetches_data/2 with valid data updates the fetches_data" do
      fetches_data = fetches_data_fixture()
      update_attrs = %{data: "some updated data", hash: "some updated hash"}

      assert {:ok, %FetchesData{} = fetches_data} =
               Fetcher.update_fetches_data(fetches_data, update_attrs)

      assert fetches_data.data == "some updated data"
      assert fetches_data.hash == "some updated hash"
    end

    test "update_fetches_data/2 with invalid data returns error changeset" do
      fetches_data = fetches_data_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Fetcher.update_fetches_data(fetches_data, @invalid_attrs)

      assert fetches_data == Fetcher.get_fetches_data!(fetches_data.id)
    end

    test "delete_fetches_data/1 deletes the fetches_data" do
      fetches_data = fetches_data_fixture()
      assert {:ok, %FetchesData{}} = Fetcher.delete_fetches_data(fetches_data)

      assert_raise Ecto.NoResultsError, fn ->
        Fetcher.get_fetches_data!(fetches_data.id)
      end
    end

    test "change_fetches_data/1 returns a fetches_data changeset" do
      fetches_data = fetches_data_fixture()
      assert %Ecto.Changeset{} = Fetcher.change_fetches_data(fetches_data)
    end
  end

  describe "fetches" do
    alias Consume.Fetcher.Fetch

    import Consume.FetcherFixtures

    @invalid_attrs %{fetched_at: nil}

    test "list_fetches/0 returns all fetches" do
      fetch = fetch_fixture()
      assert Fetcher.list_fetches() == [fetch]
    end

    test "list_fetches_by_fetches_data/1 returns matched fetches" do
      fetches_data = fetches_data_fixture()
      match_fetch_1 = fetch_fixture(fetches_data_id: fetches_data.id)
      match_fetch_2 = fetch_fixture(fetches_data_id: fetches_data.id)
      _bad_fetch_1 = fetch_fixture()

      assert Fetcher.list_fetches_by_fetches_data(fetches_data.id) == [
               match_fetch_1,
               match_fetch_2
             ]
    end

    test "get_fetch!/1 returns the fetch with given id" do
      fetch = fetch_fixture()
      assert Fetcher.get_fetch!(fetch.id) == fetch
    end

    test "create_fetch/1 with valid data creates a fetch" do
      fetches_data = fetches_data_fixture()
      valid_attrs = %{fetched_at: ~U[2022-09-03 00:34:00Z], fetches_data_id: fetches_data.id}

      assert {:ok, %Fetch{} = fetch} = Fetcher.create_fetch(valid_attrs)
      assert fetch.fetched_at == ~U[2022-09-03 00:34:00Z]
    end

    test "create_fetch/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Fetcher.create_fetch(@invalid_attrs)
    end

    test "update_fetch/2 with valid data updates the fetch" do
      fetch = fetch_fixture()
      update_attrs = %{fetched_at: ~U[2022-09-04 00:34:00Z]}

      assert {:ok, %Fetch{} = fetch} = Fetcher.update_fetch(fetch, update_attrs)
      assert fetch.fetched_at == ~U[2022-09-04 00:34:00Z]
    end

    test "update_fetch/2 with invalid data returns error changeset" do
      fetch = fetch_fixture()
      assert {:error, %Ecto.Changeset{}} = Fetcher.update_fetch(fetch, @invalid_attrs)
      assert fetch == Fetcher.get_fetch!(fetch.id)
    end

    test "delete_fetch/1 deletes the fetch" do
      fetch = fetch_fixture()
      assert {:ok, %Fetch{}} = Fetcher.delete_fetch(fetch)
      assert_raise Ecto.NoResultsError, fn -> Fetcher.get_fetch!(fetch.id) end
    end

    test "change_fetch/1 returns a fetch changeset" do
      fetch = fetch_fixture()
      assert %Ecto.Changeset{} = Fetcher.change_fetch(fetch)
    end
  end
end
