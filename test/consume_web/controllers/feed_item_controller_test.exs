defmodule ConsumeWeb.FeedItemControllerTest do
  use ConsumeWeb.ConnCase

  import Consume.FetcherFixtures

  @create_attrs %{data: "some data", hash: "some hash"}
  @update_attrs %{data: "some updated data", hash: "some updated hash"}
  @invalid_attrs %{data: nil, hash: nil}

  describe "index" do
    test "lists all feed_items", %{conn: conn} do
      conn = get(conn, Routes.feed_item_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Feed items"
    end
  end

  describe "new feed_item" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.feed_item_path(conn, :new))
      assert html_response(conn, 200) =~ "New Feed item"
    end
  end

  describe "create feed_item" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.feed_item_path(conn, :create), feed_item: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.feed_item_path(conn, :show, id)

      conn = get(conn, Routes.feed_item_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Feed item"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.feed_item_path(conn, :create), feed_item: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Feed item"
    end
  end

  describe "edit feed_item" do
    setup [:create_feed_item]

    test "renders form for editing chosen feed_item", %{conn: conn, feed_item: feed_item} do
      conn = get(conn, Routes.feed_item_path(conn, :edit, feed_item))
      assert html_response(conn, 200) =~ "Edit Feed item"
    end
  end

  describe "update feed_item" do
    setup [:create_feed_item]

    test "redirects when data is valid", %{conn: conn, feed_item: feed_item} do
      conn = put(conn, Routes.feed_item_path(conn, :update, feed_item), feed_item: @update_attrs)
      assert redirected_to(conn) == Routes.feed_item_path(conn, :show, feed_item)

      conn = get(conn, Routes.feed_item_path(conn, :show, feed_item))
      assert html_response(conn, 200) =~ "some updated data"
    end

    test "renders errors when data is invalid", %{conn: conn, feed_item: feed_item} do
      conn = put(conn, Routes.feed_item_path(conn, :update, feed_item), feed_item: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Feed item"
    end
  end

  describe "delete feed_item" do
    setup [:create_feed_item]

    test "deletes chosen feed_item", %{conn: conn, feed_item: feed_item} do
      conn = delete(conn, Routes.feed_item_path(conn, :delete, feed_item))
      assert redirected_to(conn) == Routes.feed_item_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.feed_item_path(conn, :show, feed_item))
      end
    end
  end

  defp create_feed_item(_) do
    feed_item = feed_item_fixture()
    %{feed_item: feed_item}
  end
end
