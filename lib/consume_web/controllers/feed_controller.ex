defmodule ConsumeWeb.FeedController do
  use ConsumeWeb, :controller

  alias Consume.Fetcher
  alias Consume.Fetcher.Feed

  def index(conn, _params) do
    feeds = Fetcher.list_feeds()
    render(conn, "index.html", feeds: feeds)
  end

  def new(conn, _params) do
    changeset = Fetcher.change_feed(%Feed{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"feed" => feed_params}) do
    case Fetcher.create_feed(feed_params) do
      {:ok, feed} ->
        conn
        |> put_flash(:info, "Feed created successfully.")
        |> redirect(to: Routes.feed_path(conn, :show, feed))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    feed = Fetcher.get_feed!(id)
    render(conn, "show.html", feed: feed)
  end

  def edit(conn, %{"id" => id}) do
    feed = Fetcher.get_feed!(id)
    changeset = Fetcher.change_feed(feed)
    render(conn, "edit.html", feed: feed, changeset: changeset)
  end

  def update(conn, %{"id" => id, "feed" => feed_params}) do
    feed = Fetcher.get_feed!(id)

    case Fetcher.update_feed(feed, feed_params) do
      {:ok, feed} ->
        conn
        |> put_flash(:info, "Feed updated successfully.")
        |> redirect(to: Routes.feed_path(conn, :show, feed))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", feed: feed, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    feed = Fetcher.get_feed!(id)
    {:ok, _feed} = Fetcher.delete_feed(feed)

    conn
    |> put_flash(:info, "Feed deleted successfully.")
    |> redirect(to: Routes.feed_path(conn, :index))
  end
end
