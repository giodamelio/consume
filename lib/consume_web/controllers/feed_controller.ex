defmodule ConsumeWeb.FeedController do
  use ConsumeWeb, :controller

  alias Consume.Feeds
  alias Consume.Feeds.Feed

  def index(conn, _params) do
    feeds = Feeds.list_feeds()
    render(conn, "index.html", feeds: feeds)
  end

  def new(conn, _params) do
    changeset = Feeds.change_feed(%Feed{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"feed" => feed_params}) do
    case Feeds.create_feed(feed_params) do
      {:ok, feed} ->
        conn
        |> put_flash(:info, "Feed created successfully.")
        |> redirect(to: Routes.feed_path(conn, :show, feed))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    feed = Feeds.get_feed!(id)
    render(conn, "show.html", feed: feed)
  end

  def edit(conn, %{"id" => id}) do
    feed = Feeds.get_feed!(id)
    changeset = Feeds.change_feed(feed)
    render(conn, "edit.html", feed: feed, changeset: changeset)
  end

  def update(conn, %{"id" => id, "feed" => feed_params}) do
    feed = Feeds.get_feed!(id)

    case Feeds.update_feed(feed, feed_params) do
      {:ok, feed} ->
        conn
        |> put_flash(:info, "Feed updated successfully.")
        |> redirect(to: Routes.feed_path(conn, :show, feed))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", feed: feed, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    feed = Feeds.get_feed!(id)

    case Feeds.delete_feed(feed) do
      {:ok, _feed} ->
        conn
        |> put_flash(:info, "Feed deleted successfully.")
        |> redirect(to: Routes.feed_path(conn, :index))

      {:error, %Ecto.Changeset{} = _changeset} ->
        conn
        |> put_flash(
          :error,
          "Could not delete feed \"#{feed.name}\". Please ensure it has no Feed Fetches or Feed Fetch Data."
        )
        |> redirect(to: Routes.feed_path(conn, :index))
    end
  end
end
