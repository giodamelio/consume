defmodule Consume.Fetcher do
  @moduledoc """
  The Fetcher context.
  """

  import Ecto.Query, warn: false
  alias Consume.Repo

  alias Consume.Fetcher.FetchesData

  @doc """
  Returns the list of fetches_data.

  ## Examples

      iex> list_fetches_data()
      [%FetchesData{}, ...]

  """
  def list_fetches_data do
    Repo.all(FetchesData)
  end

  @doc """
  Gets a single fetches_data.

  Raises `Ecto.NoResultsError` if the Fetches data does not exist.

  ## Examples

      iex> get_fetches_data!(123)
      %FetchesData{}

      iex> get_fetches_data!(456)
      ** (Ecto.NoResultsError)

  """
  def get_fetches_data!(id), do: Repo.get!(FetchesData, id)

  @doc """
  Creates a fetches_data.

  ## Examples

      iex> create_fetches_data(%{field: value})
      {:ok, %FetchesData{}}

      iex> create_fetches_data(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_fetches_data(attrs \\ %{}) do
    %FetchesData{}
    |> FetchesData.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a fetches_data.

  ## Examples

      iex> update_fetches_data(fetches_data, %{field: new_value})
      {:ok, %FetchesData{}}

      iex> update_fetches_data(fetches_data, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_fetches_data(%FetchesData{} = fetches_data, attrs) do
    fetches_data
    |> FetchesData.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a fetches_data.

  ## Examples

      iex> delete_fetches_data(fetches_data)
      {:ok, %FetchesData{}}

      iex> delete_fetches_data(fetches_data)
      {:error, %Ecto.Changeset{}}

  """
  def delete_fetches_data(%FetchesData{} = fetches_data) do
    Repo.delete(fetches_data)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking fetches_data changes.

  ## Examples

      iex> change_fetches_data(fetches_data)
      %Ecto.Changeset{data: %FetchesData{}}

  """
  def change_fetches_data(%FetchesData{} = fetches_data, attrs \\ %{}) do
    FetchesData.changeset(fetches_data, attrs)
  end

  alias Consume.Fetcher.Fetch

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
  Returns the list of fetches that reference a specific fetches data
  """
  def list_fetches_by_fetches_data(id) do
    query = from(f in Fetch, where: f.fetches_data_id == ^id)

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

  alias Consume.Fetcher.Feed

  @doc """
  Returns the list of feeds.

  ## Examples

      iex> list_feeds()
      [%Feed{}, ...]

  """
  def list_feeds do
    Repo.all(Feed)
  end

  @doc """
  Gets a single feed.

  Raises `Ecto.NoResultsError` if the Feed does not exist.

  ## Examples

      iex> get_feed!(123)
      %Feed{}

      iex> get_feed!(456)
      ** (Ecto.NoResultsError)

  """
  def get_feed!(id), do: Repo.get!(Feed, id)

  @doc """
  Creates a feed.

  ## Examples

      iex> create_feed(%{field: value})
      {:ok, %Feed{}}

      iex> create_feed(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_feed(attrs \\ %{}) do
    %Feed{}
    |> Feed.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a feed.

  ## Examples

      iex> update_feed(feed, %{field: new_value})
      {:ok, %Feed{}}

      iex> update_feed(feed, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_feed(%Feed{} = feed, attrs) do
    feed
    |> Feed.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a feed.

  ## Examples

      iex> delete_feed(feed)
      {:ok, %Feed{}}

      iex> delete_feed(feed)
      {:error, %Ecto.Changeset{}}

  """
  def delete_feed(%Feed{} = feed) do
    Repo.delete(feed)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking feed changes.

  ## Examples

      iex> change_feed(feed)
      %Ecto.Changeset{data: %Feed{}}

  """
  def change_feed(%Feed{} = feed, attrs \\ %{}) do
    Feed.changeset(feed, attrs)
  end

  alias Consume.Fetcher.FeedItem

  @doc """
  Returns the list of feed_items.

  ## Examples

      iex> list_feed_items()
      [%FeedItem{}, ...]

  """
  def list_feed_items do
    Repo.all(FeedItem)
  end

  @doc """
  Gets a single feed_item.

  Raises `Ecto.NoResultsError` if the Feed item does not exist.

  ## Examples

      iex> get_feed_item!(123)
      %FeedItem{}

      iex> get_feed_item!(456)
      ** (Ecto.NoResultsError)

  """
  def get_feed_item!(id), do: Repo.get!(FeedItem, id)

  @doc """
  Creates a feed_item.

  ## Examples

      iex> create_feed_item(%{field: value})
      {:ok, %FeedItem{}}

      iex> create_feed_item(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_feed_item(attrs \\ %{}) do
    %FeedItem{}
    |> FeedItem.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a feed_item.

  ## Examples

      iex> update_feed_item(feed_item, %{field: new_value})
      {:ok, %FeedItem{}}

      iex> update_feed_item(feed_item, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_feed_item(%FeedItem{} = feed_item, attrs) do
    feed_item
    |> FeedItem.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a feed_item.

  ## Examples

      iex> delete_feed_item(feed_item)
      {:ok, %FeedItem{}}

      iex> delete_feed_item(feed_item)
      {:error, %Ecto.Changeset{}}

  """
  def delete_feed_item(%FeedItem{} = feed_item) do
    Repo.delete(feed_item)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking feed_item changes.

  ## Examples

      iex> change_feed_item(feed_item)
      %Ecto.Changeset{data: %FeedItem{}}

  """
  def change_feed_item(%FeedItem{} = feed_item, attrs \\ %{}) do
    FeedItem.changeset(feed_item, attrs)
  end
end
