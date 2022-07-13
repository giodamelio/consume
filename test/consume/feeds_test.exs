defmodule Consume.FeedsTest do
  use Consume.DataCase

  alias Consume.Feeds

  describe "feeds" do
    alias Consume.Feeds.Feed

    import Consume.FeedsFixtures

    @invalid_attrs %{
      fetch_frequency_seconds: nil,
      fetch_after: nil,
      name: nil,
      fetcher: nil,
      parser: nil,
      url: nil
    }

    test "list_feeds/0 returns all feeds" do
      feed = feed_fixture()
      assert Feeds.list_feeds() == [feed]
    end

    test "list_fetchable_feeds/0 returns feeds that have not been fetched before" do
      never_fetched_feed = feed_fixture(%{fetch_after: nil})

      assert Feeds.list_fetchable_feeds() == [never_fetched_feed]
    end

    test "list_fetchable_feeds/0 returns datetimes in the past" do
      one_hour_ago = DateTime.now!("Etc/UTC") |> DateTime.add(-(60 * 60), :second)
      future_feed = feed_fixture(%{fetch_after: one_hour_ago})

      assert Feeds.list_fetchable_feeds() == [future_feed]
    end

    test "list_fetchable_feeds/0 doesn't return for datetimes in the future" do
      one_hour_from_now = DateTime.now!("Etc/UTC") |> DateTime.add(60 * 60, :second)
      _future_feed = feed_fixture(%{fetch_after: one_hour_from_now})

      assert Feeds.list_fetchable_feeds() == []
    end

    test "get_feed!/1 returns the feed with given id" do
      feed = feed_fixture()
      assert Feeds.get_feed!(feed.id) == feed
    end

    test "create_feed/1 with valid data creates a feed" do
      valid_attrs = %{
        fetch_frequency_seconds: 42,
        fetch_after: ~U[2022-07-07 02:04:00Z],
        name: "some name",
        fetcher: :http_get,
        parser: :rss2_0,
        url: "some url",
        enabled: false
      }

      assert {:ok, %Feed{} = feed} = Feeds.create_feed(valid_attrs)
      assert feed.fetch_frequency_seconds == 42
      assert feed.fetch_after == ~U[2022-07-07 02:04:00Z]
      assert feed.name == "some name"
      assert feed.fetcher == :http_get
      assert feed.parser == :rss2_0
      assert feed.url == "some url"
    end

    test "create_feed/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Feeds.create_feed(@invalid_attrs)
    end

    test "update_feed/2 with valid data updates the feed" do
      feed = feed_fixture()

      update_attrs = %{
        fetch_frequency_seconds: 43,
        fetch_after: ~U[2022-07-08 02:04:00Z],
        name: "some updated name",
        fetcher: :http_get,
        parser: :jsonfeed,
        url: "some updated url"
      }

      assert {:ok, %Feed{} = feed} = Feeds.update_feed(feed, update_attrs)
      assert feed.fetch_frequency_seconds == 43
      assert feed.fetch_after == ~U[2022-07-08 02:04:00Z]
      assert feed.name == "some updated name"
      assert feed.fetcher == :http_get
      assert feed.parser == :jsonfeed
      assert feed.url == "some updated url"
    end

    test "update_feed/2 with invalid data returns error changeset" do
      feed = feed_fixture()
      assert {:error, %Ecto.Changeset{}} = Feeds.update_feed(feed, @invalid_attrs)
      assert feed == Feeds.get_feed!(feed.id)
    end

    test "delete_feed/1 deletes the feed" do
      feed = feed_fixture()
      assert {:ok, %Feed{}} = Feeds.delete_feed(feed)
      assert_raise Ecto.NoResultsError, fn -> Feeds.get_feed!(feed.id) end
    end

    test "delete_feed/1 cannot delete if a feed_fetches exists that belongs to it" do
      feed = feed_fixture()
      _feed_fetch = feed_fetch_fixture(feed_id: feed.id)

      {:error, %Ecto.Changeset{errors: errors}} = Feeds.delete_feed(feed)
      error_name = errors |> Keyword.fetch!(:feed_fetches) |> elem(0)
      assert error_name == "are still associated with this entry"
    end

    test "delete_feed/1 cannot delete if a feed_fetch_data exists that belongs to it" do
      feed = feed_fixture()
      _feed_fetch_data = feed_fetch_data_fixture(feed_id: feed.id)

      {:error, %Ecto.Changeset{errors: errors}} = Feeds.delete_feed(feed)
      error_name = errors |> Keyword.fetch!(:feed_fetch_data) |> elem(0)
      assert error_name == "are still associated with this entry"
    end

    test "change_feed/1 returns a feed changeset" do
      feed = feed_fixture()
      assert %Ecto.Changeset{} = Feeds.change_feed(feed)
    end
  end

  describe "feed_fetches" do
    alias Consume.Feeds.FeedFetch

    import Consume.FeedsFixtures

    @invalid_attrs %{feed_id: nil}

    test "list_feed_fetches/0 returns all feed_fetches" do
      feed_fetch = feed_fetch_fixture()
      assert Feeds.list_feed_fetches() == [feed_fetch]
    end

    test "list_feed_fetches_by_feed/1 returns all feed_fetches that match the correct feed" do
      feed_fetch_fixture()
      feed_fetch_fixture()
      feed_fetch = feed_fetch_fixture()

      assert Feeds.list_feed_fetches_by_feed(feed_fetch.feed_id) == [feed_fetch]
    end

    test "get_feed_fetch!/1 returns the feed_fetch with given id" do
      feed_fetch = feed_fetch_fixture()
      assert Feeds.get_feed_fetch!(feed_fetch.id) == feed_fetch
    end

    test "create_feed_fetch/1 with valid data creates a feed_fetch" do
      feed = feed_fixture()
      feed_fetch_data = feed_fetch_data_fixture()

      valid_attrs = %{
        feed_id: feed.id,
        feed_fetch_data_id: feed_fetch_data.id
      }

      assert {:ok, %FeedFetch{} = feed_fetch} = Feeds.create_feed_fetch(valid_attrs)
      assert feed_fetch.feed_id == feed.id
      assert feed_fetch.feed_fetch_data_id == feed_fetch_data.id
    end

    test "create_feed_fetch/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Feeds.create_feed_fetch(@invalid_attrs)
    end

    test "update_feed_fetch/2 with valid data updates the feed_fetch" do
      feed_fetch = feed_fetch_fixture()
      feed2 = feed_fixture()
      update_attrs = %{feed_id: feed2.id}

      assert {:ok, %FeedFetch{} = feed_fetch} = Feeds.update_feed_fetch(feed_fetch, update_attrs)
      assert feed_fetch.feed_id == feed2.id
    end

    test "update_feed_fetch/2 with invalid data returns error changeset" do
      feed_fetch = feed_fetch_fixture()
      assert {:error, %Ecto.Changeset{}} = Feeds.update_feed_fetch(feed_fetch, @invalid_attrs)
      assert feed_fetch == Feeds.get_feed_fetch!(feed_fetch.id)
    end

    test "delete_feed_fetch/1 deletes the feed_fetch" do
      feed_fetch = feed_fetch_fixture()
      assert {:ok, %FeedFetch{}} = Feeds.delete_feed_fetch(feed_fetch)
      assert_raise Ecto.NoResultsError, fn -> Feeds.get_feed_fetch!(feed_fetch.id) end
    end

    test "change_feed_fetch/1 returns a feed_fetch changeset" do
      feed_fetch = feed_fetch_fixture()
      assert %Ecto.Changeset{} = Feeds.change_feed_fetch(feed_fetch)
    end
  end

  describe "feed_fetch_data" do
    alias Consume.Feeds.FeedFetchData

    import Consume.FeedsFixtures

    @invalid_attrs %{data: nil}

    test "list_feed_fetch_data/0 returns all feed_fetch_data" do
      feed_fetch_data = feed_fetch_data_fixture()
      assert Feeds.list_feed_fetch_data() == [feed_fetch_data]
    end

    test "get_feed_fetch_data!/1 returns the feed_fetch_data with given id" do
      feed_fetch_data = feed_fetch_data_fixture()
      assert Feeds.get_feed_fetch_data!(feed_fetch_data.id) == feed_fetch_data
    end

    test "create_feed_fetch_data/1 with valid data creates a feed_fetch_data" do
      feed = feed_fixture()
      valid_attrs = %{data: "some data", feed_id: feed.id}

      assert {:ok, %FeedFetchData{} = feed_fetch_data} = Feeds.create_feed_fetch_data(valid_attrs)
      assert feed_fetch_data.data == "some data"

      assert feed_fetch_data.sha256 ==
               "1307990E6BA5CA145EB35E99182A9BEC46531BC54DDF656A602C780FA0240DEE"
    end

    test "create_feed_fetch_data/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Feeds.create_feed_fetch_data(@invalid_attrs)
    end

    test "upsert_feed_fetch_data/1 with valid data creates a feed_fetch_data" do
      feed = feed_fixture()
      valid_attrs = %{data: "some data", feed_id: feed.id}

      assert {:ok, %FeedFetchData{} = feed_fetch_data} = Feeds.upsert_feed_fetch_data(valid_attrs)

      assert feed_fetch_data.data == "some data"

      assert feed_fetch_data.sha256 ==
               "1307990E6BA5CA145EB35E99182A9BEC46531BC54DDF656A602C780FA0240DEE"
    end

    test "upsert_feed_fetch_data/1 returns original feed_fetch_data on duplicate" do
      feed = feed_fixture()
      valid_attrs = %{data: "some data", feed_id: feed.id}

      assert {:ok, %FeedFetchData{} = feed_fetch_data} = Feeds.upsert_feed_fetch_data(valid_attrs)

      assert {:ok, %FeedFetchData{} = feed_fetch_data_2} =
               Feeds.upsert_feed_fetch_data(valid_attrs)

      assert feed_fetch_data.id == feed_fetch_data_2.id
      assert feed_fetch_data.updated_at == feed_fetch_data_2.updated_at
    end

    test "update_feed_fetch_data/2 with valid data updates the feed_fetch_data" do
      feed_fetch_data = feed_fetch_data_fixture()
      update_attrs = %{data: "some updated data"}

      assert {:ok, %FeedFetchData{} = feed_fetch_data} =
               Feeds.update_feed_fetch_data(feed_fetch_data, update_attrs)

      assert feed_fetch_data.data == "some updated data"

      assert feed_fetch_data.sha256 ==
               "F47C56E3430C735356CBB66685B6F15425178E47420046E11824391EF4F7FBC1"
    end

    test "update_feed_fetch_data/2 with invalid data returns error changeset" do
      feed_fetch_data = feed_fetch_data_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Feeds.update_feed_fetch_data(feed_fetch_data, @invalid_attrs)

      assert feed_fetch_data == Feeds.get_feed_fetch_data!(feed_fetch_data.id)
    end

    test "delete_feed_fetch_data/1 deletes the feed_fetch_data" do
      feed_fetch_data = feed_fetch_data_fixture()
      assert {:ok, %FeedFetchData{}} = Feeds.delete_feed_fetch_data(feed_fetch_data)
      assert_raise Ecto.NoResultsError, fn -> Feeds.get_feed_fetch_data!(feed_fetch_data.id) end
    end

    test "change_feed_fetch_data/1 returns a feed_fetch_data changeset" do
      feed_fetch_data = feed_fetch_data_fixture()
      assert %Ecto.Changeset{} = Feeds.change_feed_fetch_data(feed_fetch_data)
    end
  end
end
