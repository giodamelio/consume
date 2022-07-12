defmodule ConsumeWeb.FeedFetchDataController do
  use ConsumeWeb, :controller

  alias Consume.Feeds
  alias Consume.Feeds.FeedFetchData

  def index(conn, _params) do
    feed_fetch_data = Feeds.list_feed_fetch_data()
    render(conn, "index.html", feed_fetch_data: feed_fetch_data)
  end

  def new(conn, _params) do
    changeset = Feeds.change_feed_fetch_data(%FeedFetchData{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"feed_fetch_data" => feed_fetch_data_params}) do
    case Feeds.create_feed_fetch_data(feed_fetch_data_params) do
      {:ok, feed_fetch_data} ->
        conn
        |> put_flash(:info, "Feed fetch data created successfully.")
        |> redirect(to: Routes.feed_fetch_data_path(conn, :show, feed_fetch_data))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    feed_fetch_data = Feeds.get_feed_fetch_data!(id)
    render(conn, "show.html", feed_fetch_data: feed_fetch_data)
  end

  def edit(conn, %{"id" => id}) do
    feed_fetch_data = Feeds.get_feed_fetch_data!(id)
    changeset = Feeds.change_feed_fetch_data(feed_fetch_data)
    render(conn, "edit.html", feed_fetch_data: feed_fetch_data, changeset: changeset)
  end

  def update(conn, %{"id" => id, "feed_fetch_data" => feed_fetch_data_params}) do
    feed_fetch_data = Feeds.get_feed_fetch_data!(id)

    case Feeds.update_feed_fetch_data(feed_fetch_data, feed_fetch_data_params) do
      {:ok, feed_fetch_data} ->
        conn
        |> put_flash(:info, "Feed fetch data updated successfully.")
        |> redirect(to: Routes.feed_fetch_data_path(conn, :show, feed_fetch_data))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", feed_fetch_data: feed_fetch_data, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    feed_fetch_data = Feeds.get_feed_fetch_data!(id)
    {:ok, _feed_fetch_data} = Feeds.delete_feed_fetch_data(feed_fetch_data)

    conn
    |> put_flash(:info, "Feed fetch data deleted successfully.")
    |> redirect(to: Routes.feed_fetch_data_path(conn, :index))
  end
end
