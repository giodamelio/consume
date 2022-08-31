defmodule ConsumeWeb.RawFetchDataController do
  use ConsumeWeb, :controller

  alias Consume.Downloader
  alias Consume.Downloader.RawFetchData

  def index(conn, _params) do
    raw_fetch_data = Downloader.list_raw_fetch_data()
    render(conn, "index.html", raw_fetch_data: raw_fetch_data)
  end

  def new(conn, _params) do
    changeset = Downloader.change_raw_fetch_data(%RawFetchData{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"raw_fetch_data" => raw_fetch_data_params}) do
    case Downloader.create_raw_fetch_data(raw_fetch_data_params) do
      {:ok, raw_fetch_data} ->
        conn
        |> put_flash(:info, "Raw fetch data created successfully.")
        |> redirect(to: Routes.raw_fetch_data_path(conn, :show, raw_fetch_data))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    raw_fetch_data = Downloader.get_raw_fetch_data!(id)
    render(conn, "show.html", raw_fetch_data: raw_fetch_data)
  end

  def edit(conn, %{"id" => id}) do
    raw_fetch_data = Downloader.get_raw_fetch_data!(id)
    changeset = Downloader.change_raw_fetch_data(raw_fetch_data)
    render(conn, "edit.html", raw_fetch_data: raw_fetch_data, changeset: changeset)
  end

  def update(conn, %{"id" => id, "raw_fetch_data" => raw_fetch_data_params}) do
    raw_fetch_data = Downloader.get_raw_fetch_data!(id)

    case Downloader.update_raw_fetch_data(raw_fetch_data, raw_fetch_data_params) do
      {:ok, raw_fetch_data} ->
        conn
        |> put_flash(:info, "Raw fetch data updated successfully.")
        |> redirect(to: Routes.raw_fetch_data_path(conn, :show, raw_fetch_data))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", raw_fetch_data: raw_fetch_data, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    raw_fetch_data = Downloader.get_raw_fetch_data!(id)
    {:ok, _raw_fetch_data} = Downloader.delete_raw_fetch_data(raw_fetch_data)

    conn
    |> put_flash(:info, "Raw fetch data deleted successfully.")
    |> redirect(to: Routes.raw_fetch_data_path(conn, :index))
  end
end