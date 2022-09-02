defmodule ConsumeWeb.RawFetchDataControllerTest do
  use ConsumeWeb.ConnCase

  import Consume.DownloaderFixtures

  @create_attrs %{data: "some data", hash: "some hash"}
  @update_attrs %{data: "some updated data", hash: "some updated hash"}
  @invalid_attrs %{data: nil, hash: nil}

  describe "index" do
    test "lists all raw_fetch_data", %{conn: conn} do
      conn = get(conn, Routes.raw_fetch_data_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Raw Fetch Data"
    end
  end

  describe "new raw_fetch_data" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.raw_fetch_data_path(conn, :new))
      assert html_response(conn, 200) =~ "New Raw Fetch Data"
    end
  end

  describe "create raw_fetch_data" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.raw_fetch_data_path(conn, :create), raw_fetch_data: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.raw_fetch_data_path(conn, :show, id)

      conn = get(conn, Routes.raw_fetch_data_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Raw Fetch Data"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.raw_fetch_data_path(conn, :create), raw_fetch_data: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Raw Fetch Data"
    end
  end

  describe "edit raw_fetch_data" do
    setup [:create_raw_fetch_data]

    test "renders form for editing chosen raw_fetch_data", %{
      conn: conn,
      raw_fetch_data: raw_fetch_data
    } do
      conn = get(conn, Routes.raw_fetch_data_path(conn, :edit, raw_fetch_data))
      assert html_response(conn, 200) =~ "Edit Raw Fetch Data"
    end
  end

  describe "update raw_fetch_data" do
    setup [:create_raw_fetch_data]

    test "redirects when data is valid", %{conn: conn, raw_fetch_data: raw_fetch_data} do
      conn =
        put(conn, Routes.raw_fetch_data_path(conn, :update, raw_fetch_data),
          raw_fetch_data: @update_attrs
        )

      assert redirected_to(conn) == Routes.raw_fetch_data_path(conn, :show, raw_fetch_data)

      conn = get(conn, Routes.raw_fetch_data_path(conn, :show, raw_fetch_data))
      assert html_response(conn, 200) =~ "some updated hash"
    end

    test "renders errors when data is invalid", %{conn: conn, raw_fetch_data: raw_fetch_data} do
      conn =
        put(conn, Routes.raw_fetch_data_path(conn, :update, raw_fetch_data),
          raw_fetch_data: @invalid_attrs
        )

      assert html_response(conn, 200) =~ "Edit Raw Fetch Data"
    end
  end

  describe "delete raw_fetch_data" do
    setup [:create_raw_fetch_data]

    test "deletes chosen raw_fetch_data", %{conn: conn, raw_fetch_data: raw_fetch_data} do
      conn = delete(conn, Routes.raw_fetch_data_path(conn, :delete, raw_fetch_data))
      assert redirected_to(conn) == Routes.raw_fetch_data_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.raw_fetch_data_path(conn, :show, raw_fetch_data))
      end
    end
  end

  defp create_raw_fetch_data(_) do
    raw_fetch_data = raw_fetch_data_fixture()
    %{raw_fetch_data: raw_fetch_data}
  end
end
