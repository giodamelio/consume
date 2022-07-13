defmodule ConsumeWeb.FeedFetchControllerTest do
  use ConsumeWeb.ConnCase

  import Consume.FeedsFixtures

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{feed_id: nil}

  describe "index" do
    test "lists all feed_fetches", %{conn: conn} do
      conn = get(conn, Routes.feed_fetch_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Feed fetches"
    end
  end

  describe "new feed_fetch" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.feed_fetch_path(conn, :new))
      assert html_response(conn, 200) =~ "New Feed fetch"
    end
  end

  describe "create feed_fetch" do
    test "redirects to show when data is valid", %{conn: conn} do
      feed = feed_fixture()
      feed_fetch_data = feed_fetch_data_fixture()

      conn =
        post(conn, Routes.feed_fetch_path(conn, :create),
          feed_fetch:
            @create_attrs
            |> Map.put(:feed_id, feed.id)
            |> Map.put(:feed_fetch_data_id, feed_fetch_data.id)
        )

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.feed_fetch_path(conn, :show, id)

      conn = get(conn, Routes.feed_fetch_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Feed fetch"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.feed_fetch_path(conn, :create), feed_fetch: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Feed fetch"
    end
  end

  describe "edit feed_fetch" do
    setup [:create_feed_fetch]

    test "renders form for editing chosen feed_fetch", %{conn: conn, feed_fetch: feed_fetch} do
      conn = get(conn, Routes.feed_fetch_path(conn, :edit, feed_fetch))
      assert html_response(conn, 200) =~ "Edit Feed fetch"
    end
  end

  describe "update feed_fetch" do
    setup [:create_feed_fetch]

    test "redirects when data is valid", %{conn: conn, feed_fetch: feed_fetch} do
      conn =
        put(conn, Routes.feed_fetch_path(conn, :update, feed_fetch), feed_fetch: @update_attrs)

      assert redirected_to(conn) == Routes.feed_fetch_path(conn, :show, feed_fetch)

      conn = get(conn, Routes.feed_fetch_path(conn, :show, feed_fetch))

      assert html_response(conn, 200) =~ to_string(feed_fetch.feed_id)
    end

    test "renders errors when data is invalid", %{conn: conn, feed_fetch: feed_fetch} do
      conn =
        put(conn, Routes.feed_fetch_path(conn, :update, feed_fetch), feed_fetch: @invalid_attrs)

      assert html_response(conn, 200) =~ "Edit Feed fetch"
    end
  end

  describe "delete feed_fetch" do
    setup [:create_feed_fetch]

    test "deletes chosen feed_fetch", %{conn: conn, feed_fetch: feed_fetch} do
      conn = delete(conn, Routes.feed_fetch_path(conn, :delete, feed_fetch))
      assert redirected_to(conn) == Routes.feed_fetch_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.feed_fetch_path(conn, :show, feed_fetch))
      end
    end
  end

  defp create_feed_fetch(_) do
    feed_fetch = feed_fetch_fixture()
    %{feed_fetch: feed_fetch}
  end
end
