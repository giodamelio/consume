defmodule ConsumeWeb.FetchesDataControllerTest do
  use ConsumeWeb.ConnCase

  import Consume.FetcherFixtures

  @create_attrs %{data: "some data", hash: "some hash"}
  @update_attrs %{data: "some updated data", hash: "some updated hash"}
  @invalid_attrs %{data: nil, hash: nil}

  describe "index" do
    test "lists all fetches_data", %{conn: conn} do
      conn = get(conn, Routes.fetches_data_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Fetches Data"
    end
  end

  describe "new fetches_data" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.fetches_data_path(conn, :new))
      assert html_response(conn, 200) =~ "New Fetches Data"
    end
  end

  describe "create fetches_data" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.fetches_data_path(conn, :create), fetches_data: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.fetches_data_path(conn, :show, id)

      conn = get(conn, Routes.fetches_data_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Fetches Data"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.fetches_data_path(conn, :create), fetches_data: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Fetches Data"
    end
  end

  describe "edit fetches_data" do
    setup [:create_fetches_data]

    test "renders form for editing chosen fetches_data", %{
      conn: conn,
      fetches_data: fetches_data
    } do
      conn = get(conn, Routes.fetches_data_path(conn, :edit, fetches_data))
      assert html_response(conn, 200) =~ "Edit Fetches Data"
    end
  end

  describe "update fetches_data" do
    setup [:create_fetches_data]

    test "redirects when data is valid", %{conn: conn, fetches_data: fetches_data} do
      conn =
        put(conn, Routes.fetches_data_path(conn, :update, fetches_data),
          fetches_data: @update_attrs
        )

      assert redirected_to(conn) == Routes.fetches_data_path(conn, :show, fetches_data)

      conn = get(conn, Routes.fetches_data_path(conn, :show, fetches_data))
      assert html_response(conn, 200) =~ "some updated hash"
    end

    test "renders errors when data is invalid", %{conn: conn, fetches_data: fetches_data} do
      conn =
        put(conn, Routes.fetches_data_path(conn, :update, fetches_data),
          fetches_data: @invalid_attrs
        )

      assert html_response(conn, 200) =~ "Edit Fetches Data"
    end
  end

  describe "delete fetches_data" do
    setup [:create_fetches_data]

    test "deletes chosen fetches_data", %{conn: conn, fetches_data: fetches_data} do
      conn = delete(conn, Routes.fetches_data_path(conn, :delete, fetches_data))
      assert redirected_to(conn) == Routes.fetches_data_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.fetches_data_path(conn, :show, fetches_data))
      end
    end
  end

  defp create_fetches_data(_) do
    fetches_data = fetches_data_fixture()
    %{fetches_data: fetches_data}
  end
end
