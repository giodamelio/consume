defmodule Consume.Downloader do
  @moduledoc """
  The Downloader context.
  """

  import Ecto.Query, warn: false
  alias Consume.Repo

  alias Consume.Downloader.RawFetchData

  @doc """
  Returns the list of raw_fetch_data.

  ## Examples

      iex> list_raw_fetch_data()
      [%RawFetchData{}, ...]

  """
  def list_raw_fetch_data do
    Repo.all(RawFetchData)
  end

  @doc """
  Gets a single raw_fetch_data.

  Raises `Ecto.NoResultsError` if the Raw fetch data does not exist.

  ## Examples

      iex> get_raw_fetch_data!(123)
      %RawFetchData{}

      iex> get_raw_fetch_data!(456)
      ** (Ecto.NoResultsError)

  """
  def get_raw_fetch_data!(id), do: Repo.get!(RawFetchData, id)

  @doc """
  Creates a raw_fetch_data.

  ## Examples

      iex> create_raw_fetch_data(%{field: value})
      {:ok, %RawFetchData{}}

      iex> create_raw_fetch_data(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_raw_fetch_data(attrs \\ %{}) do
    %RawFetchData{}
    |> RawFetchData.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a raw_fetch_data.

  ## Examples

      iex> update_raw_fetch_data(raw_fetch_data, %{field: new_value})
      {:ok, %RawFetchData{}}

      iex> update_raw_fetch_data(raw_fetch_data, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_raw_fetch_data(%RawFetchData{} = raw_fetch_data, attrs) do
    raw_fetch_data
    |> RawFetchData.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a raw_fetch_data.

  ## Examples

      iex> delete_raw_fetch_data(raw_fetch_data)
      {:ok, %RawFetchData{}}

      iex> delete_raw_fetch_data(raw_fetch_data)
      {:error, %Ecto.Changeset{}}

  """
  def delete_raw_fetch_data(%RawFetchData{} = raw_fetch_data) do
    Repo.delete(raw_fetch_data)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking raw_fetch_data changes.

  ## Examples

      iex> change_raw_fetch_data(raw_fetch_data)
      %Ecto.Changeset{data: %RawFetchData{}}

  """
  def change_raw_fetch_data(%RawFetchData{} = raw_fetch_data, attrs \\ %{}) do
    RawFetchData.changeset(raw_fetch_data, attrs)
  end

  alias Consume.Downloader.Fetch

  @doc """
  Returns the list of fetches.

  ## Examples

      iex> list_fetches()
      [%Fetch{}, ...]

  """
  def list_fetches do
    Repo.all(Fetch)
  end

  @doc """
  Returns the list of fetches that reference a specific raw fetch data
  """
  def list_fetches_by_raw_fetch_data(id) do
    query = from(f in Fetch, where: f.raw_fetch_data_id == ^id)

    Repo.all(query)
  end

  @doc """
  Gets a single fetch.

  Raises `Ecto.NoResultsError` if the Fetch does not exist.

  ## Examples

      iex> get_fetch!(123)
      %Fetch{}

      iex> get_fetch!(456)
      ** (Ecto.NoResultsError)

  """
  def get_fetch!(id), do: Repo.get!(Fetch, id)

  @doc """
  Creates a fetch.

  ## Examples

      iex> create_fetch(%{field: value})
      {:ok, %Fetch{}}

      iex> create_fetch(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_fetch(attrs \\ %{}) do
    %Fetch{}
    |> Fetch.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a fetch.

  ## Examples

      iex> update_fetch(fetch, %{field: new_value})
      {:ok, %Fetch{}}

      iex> update_fetch(fetch, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_fetch(%Fetch{} = fetch, attrs) do
    fetch
    |> Fetch.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a fetch.

  ## Examples

      iex> delete_fetch(fetch)
      {:ok, %Fetch{}}

      iex> delete_fetch(fetch)
      {:error, %Ecto.Changeset{}}

  """
  def delete_fetch(%Fetch{} = fetch) do
    Repo.delete(fetch)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking fetch changes.

  ## Examples

      iex> change_fetch(fetch)
      %Ecto.Changeset{data: %Fetch{}}

  """
  def change_fetch(%Fetch{} = fetch, attrs \\ %{}) do
    Fetch.changeset(fetch, attrs)
  end
end
