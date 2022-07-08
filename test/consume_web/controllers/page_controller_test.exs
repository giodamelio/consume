defmodule ConsumeWeb.PageControllerTest do
  use ConsumeWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Quick Links"
  end
end
