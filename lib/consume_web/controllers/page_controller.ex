defmodule ConsumeWeb.PageController do
  use ConsumeWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
