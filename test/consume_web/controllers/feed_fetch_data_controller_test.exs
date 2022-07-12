defmodule ConsumeWeb.FeedFetchDataControllerTest do
  use ConsumeWeb.ConnCase

  import Consume.FeedsFixtures

  @create_attrs %{data: "some data"}
  @update_attrs %{data: "some updated data"}
  @invalid_attrs %{data: nil}

  describe "index" do
    test "lists all feed_fetch_data", %{conn: conn} do
      conn = get(conn, Routes.feed_fetch_data_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Feed fetch data"
    end
  end

  describe "new feed_fetch_data" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.feed_fetch_data_path(conn, :new))
      assert html_response(conn, 200) =~ "New Feed fetch data"
    end
  end

  describe "create feed_fetch_data" do
    test "redirects to show when data is valid", %{conn: conn} do
      feed = feed_fixture()

      conn =
        post(conn, Routes.feed_fetch_data_path(conn, :create),
          feed_fetch_data: Map.put(@create_attrs, :feed_id, feed.id)
        )

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.feed_fetch_data_path(conn, :show, id)

      conn = get(conn, Routes.feed_fetch_data_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Feed fetch data"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn =
        post(conn, Routes.feed_fetch_data_path(conn, :create), feed_fetch_data: @invalid_attrs)

      assert html_response(conn, 200) =~ "New Feed fetch data"
    end
  end

  describe "edit feed_fetch_data" do
    setup [:create_feed_fetch_data]

    test "renders form for editing chosen feed_fetch_data", %{
      conn: conn,
      feed_fetch_data: feed_fetch_data
    } do
      conn = get(conn, Routes.feed_fetch_data_path(conn, :edit, feed_fetch_data))
      assert html_response(conn, 200) =~ "Edit Feed fetch data"
    end
  end

  describe "update feed_fetch_data" do
    setup [:create_feed_fetch_data]

    test "redirects when data is valid", %{conn: conn, feed_fetch_data: feed_fetch_data} do
      conn =
        put(conn, Routes.feed_fetch_data_path(conn, :update, feed_fetch_data),
          feed_fetch_data: @update_attrs
        )

      assert redirected_to(conn) == Routes.feed_fetch_data_path(conn, :show, feed_fetch_data)

      conn = get(conn, Routes.feed_fetch_data_path(conn, :show, feed_fetch_data))

      assert html_response(conn, 200) =~
               "F47C56E3430C735356CBB66685B6F15425178E47420046E11824391EF4F7FBC1"
    end

    test "renders errors when data is invalid", %{conn: conn, feed_fetch_data: feed_fetch_data} do
      conn =
        put(conn, Routes.feed_fetch_data_path(conn, :update, feed_fetch_data),
          feed_fetch_data: @invalid_attrs
        )

      assert html_response(conn, 200) =~ "Edit Feed fetch data"
    end
  end

  describe "delete feed_fetch_data" do
    setup [:create_feed_fetch_data]

    test "deletes chosen feed_fetch_data", %{conn: conn, feed_fetch_data: feed_fetch_data} do
      conn = delete(conn, Routes.feed_fetch_data_path(conn, :delete, feed_fetch_data))
      assert redirected_to(conn) == Routes.feed_fetch_data_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.feed_fetch_data_path(conn, :show, feed_fetch_data))
      end
    end
  end

  defp create_feed_fetch_data(_) do
    feed_fetch_data = feed_fetch_data_fixture()
    %{feed_fetch_data: feed_fetch_data}
  end
end
