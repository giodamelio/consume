defmodule ConsumeWeb.FeedControllerTest do
  use ConsumeWeb.ConnCase

  import Consume.FetcherFixtures

  @create_attrs %{
    fetch_after: ~U[2022-09-11 21:50:00Z],
    fetch_interval_seconds: 42,
    fetcher: :rss2_0,
    name: "some name",
    uri: "https://nope.nope",
    enabled: false
  }
  @update_attrs %{
    fetch_after: ~U[2022-09-12 21:50:00Z],
    fetch_interval_seconds: 43,
    fetcher: :atom,
    name: "some updated name",
    uri: "https://really-nope.nope",
    enabled: true
  }
  @invalid_attrs %{
    fetch_after: nil,
    fetch_interval_seconds: nil,
    fetcher: nil,
    name: nil,
    enabled: nil
  }

  describe "index" do
    test "lists all feeds", %{conn: conn} do
      conn = get(conn, Routes.feed_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Feeds"
    end
  end

  describe "new feed" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.feed_path(conn, :new))
      assert html_response(conn, 200) =~ "New Feed"
    end
  end

  describe "create feed" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.feed_path(conn, :create), feed: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.feed_path(conn, :show, id)

      conn = get(conn, Routes.feed_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Feed"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.feed_path(conn, :create), feed: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Feed"
    end
  end

  describe "edit feed" do
    setup [:create_feed]

    test "renders form for editing chosen feed", %{conn: conn, feed: feed} do
      conn = get(conn, Routes.feed_path(conn, :edit, feed))
      assert html_response(conn, 200) =~ "Edit Feed"
    end
  end

  describe "update feed" do
    setup [:create_feed]

    test "redirects when data is valid", %{conn: conn, feed: feed} do
      conn = put(conn, Routes.feed_path(conn, :update, feed), feed: @update_attrs)
      assert redirected_to(conn) == Routes.feed_path(conn, :show, feed)

      conn = get(conn, Routes.feed_path(conn, :show, feed))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, feed: feed} do
      conn = put(conn, Routes.feed_path(conn, :update, feed), feed: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Feed"
    end
  end

  describe "delete feed" do
    setup [:create_feed]

    test "deletes chosen feed", %{conn: conn, feed: feed} do
      conn = delete(conn, Routes.feed_path(conn, :delete, feed))
      assert redirected_to(conn) == Routes.feed_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.feed_path(conn, :show, feed))
      end
    end
  end

  defp create_feed(_) do
    feed = feed_fixture()
    %{feed: feed}
  end
end
