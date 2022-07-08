defmodule ConsumeWeb.FeedFetchController do
  use ConsumeWeb, :controller

  alias Consume.Feeds
  alias Consume.Feeds.FeedFetch

  def index(conn, _params) do
    feed_fetches = Feeds.list_feed_fetches()
    render(conn, "index.html", feed_fetches: feed_fetches)
  end

  def new(conn, _params) do
    changeset = Feeds.change_feed_fetch(%FeedFetch{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"feed_fetch" => feed_fetch_params}) do
    case Feeds.create_feed_fetch(feed_fetch_params) do
      {:ok, feed_fetch} ->
        conn
        |> put_flash(:info, "Feed fetch created successfully.")
        |> redirect(to: Routes.feed_fetch_path(conn, :show, feed_fetch))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    feed_fetch = Feeds.get_feed_fetch!(id)
    render(conn, "show.html", feed_fetch: feed_fetch)
  end

  def edit(conn, %{"id" => id}) do
    feed_fetch = Feeds.get_feed_fetch!(id)
    changeset = Feeds.change_feed_fetch(feed_fetch)
    render(conn, "edit.html", feed_fetch: feed_fetch, changeset: changeset)
  end

  def update(conn, %{"id" => id, "feed_fetch" => feed_fetch_params}) do
    feed_fetch = Feeds.get_feed_fetch!(id)

    case Feeds.update_feed_fetch(feed_fetch, feed_fetch_params) do
      {:ok, feed_fetch} ->
        conn
        |> put_flash(:info, "Feed fetch updated successfully.")
        |> redirect(to: Routes.feed_fetch_path(conn, :show, feed_fetch))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", feed_fetch: feed_fetch, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    feed_fetch = Feeds.get_feed_fetch!(id)
    {:ok, _feed_fetch} = Feeds.delete_feed_fetch(feed_fetch)

    conn
    |> put_flash(:info, "Feed fetch deleted successfully.")
    |> redirect(to: Routes.feed_fetch_path(conn, :index))
  end
end
