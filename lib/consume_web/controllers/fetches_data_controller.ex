defmodule ConsumeWeb.FetchesDataController do
  use ConsumeWeb, :controller

  alias Consume.Fetcher
  alias Consume.Fetcher.FetchesData

  def index(conn, _params) do
    fetches_data = Fetcher.list_fetches_data()
    render(conn, "index.html", fetches_data: fetches_data)
  end

  def new(conn, _params) do
    changeset = Fetcher.change_fetches_data(%FetchesData{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"fetches_data" => fetches_data_params}) do
    case Fetcher.create_fetches_data(fetches_data_params) do
      {:ok, fetches_data} ->
        conn
        |> put_flash(:info, "Fetches data created successfully.")
        |> redirect(to: Routes.fetches_data_path(conn, :show, fetches_data))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    fetches_data = Fetcher.get_fetches_data!(id)
    render(conn, "show.html", fetches_data: fetches_data)
  end

  def edit(conn, %{"id" => id}) do
    fetches_data = Fetcher.get_fetches_data!(id)
    changeset = Fetcher.change_fetches_data(fetches_data)
    render(conn, "edit.html", fetches_data: fetches_data, changeset: changeset)
  end

  def update(conn, %{"id" => id, "fetches_data" => fetches_data_params}) do
    fetches_data = Fetcher.get_fetches_data!(id)

    case Fetcher.update_fetches_data(fetches_data, fetches_data_params) do
      {:ok, fetches_data} ->
        conn
        |> put_flash(:info, "Fetches data updated successfully.")
        |> redirect(to: Routes.fetches_data_path(conn, :show, fetches_data))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", fetches_data: fetches_data, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    fetches_data = Fetcher.get_fetches_data!(id)
    {:ok, _fetches_data} = Fetcher.delete_fetches_data(fetches_data)

    conn
    |> put_flash(:info, "Fetches data deleted successfully.")
    |> redirect(to: Routes.fetches_data_path(conn, :index))
  end
end
