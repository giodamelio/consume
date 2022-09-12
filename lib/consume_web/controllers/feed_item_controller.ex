defmodule ConsumeWeb.FeedItemController do
  use ConsumeWeb, :controller

  alias Consume.Fetcher
  alias Consume.Fetcher.FeedItem

  def index(conn, _params) do
    feed_items = Fetcher.list_feed_items()
    render(conn, "index.html", feed_items: feed_items)
  end

  def new(conn, _params) do
    changeset = Fetcher.change_feed_item(%FeedItem{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"feed_item" => feed_item_params}) do
    case Fetcher.create_feed_item(feed_item_params) do
      {:ok, feed_item} ->
        conn
        |> put_flash(:info, "Feed item created successfully.")
        |> redirect(to: Routes.feed_item_path(conn, :show, feed_item))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    feed_item = Fetcher.get_feed_item!(id)
    render(conn, "show.html", feed_item: feed_item)
  end

  def edit(conn, %{"id" => id}) do
    feed_item = Fetcher.get_feed_item!(id)
    changeset = Fetcher.change_feed_item(feed_item)
    render(conn, "edit.html", feed_item: feed_item, changeset: changeset)
  end

  def update(conn, %{"id" => id, "feed_item" => feed_item_params}) do
    feed_item = Fetcher.get_feed_item!(id)

    case Fetcher.update_feed_item(feed_item, feed_item_params) do
      {:ok, feed_item} ->
        conn
        |> put_flash(:info, "Feed item updated successfully.")
        |> redirect(to: Routes.feed_item_path(conn, :show, feed_item))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", feed_item: feed_item, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    feed_item = Fetcher.get_feed_item!(id)
    {:ok, _feed_item} = Fetcher.delete_feed_item(feed_item)

    conn
    |> put_flash(:info, "Feed item deleted successfully.")
    |> redirect(to: Routes.feed_item_path(conn, :index))
  end
end
