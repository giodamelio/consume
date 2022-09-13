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

  describe "feeds" do
    alias Consume.Fetcher.Feed

    import Consume.FetcherFixtures

    @invalid_attrs %{fetch_after: nil, fetch_interval_seconds: nil, fetcher: nil, name: nil}

    test "list_feeds/0 returns all feeds" do
      feed = feed_fixture()
      assert Fetcher.list_feeds() == [feed]
    end

    test "get_feed!/1 returns the feed with given id" do
      feed = feed_fixture()
      assert Fetcher.get_feed!(feed.id) == feed
    end

    test "create_feed/1 with valid data creates a feed" do
      valid_attrs = %{
        fetch_after: ~U[2022-09-11 21:50:00.000000Z],
        fetch_interval_seconds: 42,
        fetcher: :rss2_0,
        name: "some name",
        uri: "https://nope.nope",
        enabled: false
      }

      assert {:ok, %Feed{} = feed} = Fetcher.create_feed(valid_attrs)
      assert feed.fetch_after == ~U[2022-09-11 21:50:00.000000Z]
      assert feed.fetch_interval_seconds == 42
      assert feed.fetcher == :rss2_0
      assert feed.name == "some name"
    end

    test "create_feed/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Fetcher.create_feed(@invalid_attrs)
    end

    test "update_feed/2 with valid data updates the feed" do
      feed = feed_fixture()

      update_attrs = %{
        fetch_after: ~U[2022-09-12 21:50:00.000000Z],
        fetch_interval_seconds: 43,
        fetcher: :atom,
        name: "some updated name"
      }

      assert {:ok, %Feed{} = feed} = Fetcher.update_feed(feed, update_attrs)
      assert feed.fetch_after == ~U[2022-09-12 21:50:00.000000Z]
      assert feed.fetch_interval_seconds == 43
      assert feed.fetcher == :atom
      assert feed.name == "some updated name"
    end

    test "update_feed/2 with invalid data returns error changeset" do
      feed = feed_fixture()
      assert {:error, %Ecto.Changeset{}} = Fetcher.update_feed(feed, @invalid_attrs)
      assert feed == Fetcher.get_feed!(feed.id)
    end

    test "delete_feed/1 deletes the feed" do
      feed = feed_fixture()
      assert {:ok, %Feed{}} = Fetcher.delete_feed(feed)
      assert_raise Ecto.NoResultsError, fn -> Fetcher.get_feed!(feed.id) end
    end

    test "change_feed/1 returns a feed changeset" do
      feed = feed_fixture()
      assert %Ecto.Changeset{} = Fetcher.change_feed(feed)
    end
  end

  describe "feed_items" do
    alias Consume.Fetcher.FeedItem

    import Consume.FetcherFixtures

    @invalid_attrs %{data: nil, hash: nil}

    test "list_feed_items/0 returns all feed_items" do
      feed_item = feed_item_fixture()
      assert Fetcher.list_feed_items() == [feed_item]
    end

    test "get_feed_item!/1 returns the feed_item with given id" do
      feed_item = feed_item_fixture()
      assert Fetcher.get_feed_item!(feed_item.id) == feed_item
    end

    test "create_feed_item/1 with valid data creates a feed_item" do
      feed = feed_fixture()
      valid_attrs = %{data: "some data", hash: "some hash", feed_id: feed.id}

      assert {:ok, %FeedItem{} = feed_item} = Fetcher.create_feed_item(valid_attrs)
      assert feed_item.data == "some data"
      assert feed_item.hash == "some hash"
    end

    test "create_feed_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Fetcher.create_feed_item(@invalid_attrs)
    end

    test "update_feed_item/2 with valid data updates the feed_item" do
      feed_item = feed_item_fixture()
      update_attrs = %{data: "some updated data", hash: "some updated hash"}

      assert {:ok, %FeedItem{} = feed_item} = Fetcher.update_feed_item(feed_item, update_attrs)
      assert feed_item.data == "some updated data"
      assert feed_item.hash == "some updated hash"
    end

    test "update_feed_item/2 with invalid data returns error changeset" do
      feed_item = feed_item_fixture()
      assert {:error, %Ecto.Changeset{}} = Fetcher.update_feed_item(feed_item, @invalid_attrs)
      assert feed_item == Fetcher.get_feed_item!(feed_item.id)
    end

    test "delete_feed_item/1 deletes the feed_item" do
      feed_item = feed_item_fixture()
      assert {:ok, %FeedItem{}} = Fetcher.delete_feed_item(feed_item)
      assert_raise Ecto.NoResultsError, fn -> Fetcher.get_feed_item!(feed_item.id) end
    end

    test "change_feed_item/1 returns a feed_item changeset" do
      feed_item = feed_item_fixture()
      assert %Ecto.Changeset{} = Fetcher.change_feed_item(feed_item)
    end
  end
end
