defmodule ConsumeWeb.FetchController do
  use ConsumeWeb, :controller

  alias Consume.Downloader
  alias Consume.Downloader.Fetch

  def index(conn, %{"raw_fetch_data_id" => raw_fetch_data_id}) do
    fetches = Downloader.list_fetches_by_raw_fetch_data(String.to_integer(raw_fetch_data_id))
    render(conn, "index.html", fetches: fetches, for: raw_fetch_data_id)
  end

  def index(conn, _params) do
    fetches = Downloader.list_fetches()
    render(conn, "index.html", fetches: fetches, for: nil)
  end

  def new(conn, _params) do
    changeset = Downloader.change_fetch(%Fetch{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"fetch" => fetch_params}) do
    case Downloader.create_fetch(fetch_params) do
      {:ok, fetch} ->
        conn
        |> put_flash(:info, "Fetch created successfully.")
        |> redirect(to: Routes.fetch_path(conn, :show, fetch))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    fetch = Downloader.get_fetch!(id)
    render(conn, "show.html", fetch: fetch)
  end

  def edit(conn, %{"id" => id}) do
    fetch = Downloader.get_fetch!(id)
    changeset = Downloader.change_fetch(fetch)
    render(conn, "edit.html", fetch: fetch, changeset: changeset)
  end

  def update(conn, %{"id" => id, "fetch" => fetch_params}) do
    fetch = Downloader.get_fetch!(id)

    case Downloader.update_fetch(fetch, fetch_params) do
      {:ok, fetch} ->
        conn
        |> put_flash(:info, "Fetch updated successfully.")
        |> redirect(to: Routes.fetch_path(conn, :show, fetch))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", fetch: fetch, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    fetch = Downloader.get_fetch!(id)
    {:ok, _fetch} = Downloader.delete_fetch(fetch)

    conn
    |> put_flash(:info, "Fetch deleted successfully.")
    |> redirect(to: Routes.fetch_path(conn, :index))
  end
end
