defmodule Consume.Feeds do
  @moduledoc """
  The Feeds context.
  """

  import Ecto.Query, warn: false
  alias Consume.Repo

  alias Consume.Feeds.Feed

  @doc """
  Returns the list of feeds.

  ## Examples

      iex> list_feeds()
      [%Feed{}, ...]

  """
  def list_feeds do
    Repo.all(Feed)
  end

  defp fetchable_feeds() do
    now = DateTime.utc_now()

    from feed in Feed,
      where: is_nil(feed.fetch_after),
      or_where: feed.fetch_after < ^now
  end

  @doc """
  Returns the list feeds that are ready to be fetched

  ## Examples

      iex> list_fetchable_feeds()
      [%Feed{}, ...]
  """
  def list_fetchable_feeds do
    Repo.all(fetchable_feeds())
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
    feed
    |> Feed.delete_changeset()
    |> Repo.delete()
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

  alias Consume.Feeds.FeedFetch

  @doc """
  Returns the list of feed_fetches.

  ## Examples

      iex> list_feed_fetches()
      [%FeedFetch{}, ...]

  """
  def list_feed_fetches do
    Repo.all(FeedFetch)
  end

  @doc """
  Returns the list of feed_fetches that belong to a specific feed.

  ## Examples

      iex> list_feed_fetches_by_feed(2)
      [%FeedFetch{}, ...]

  """
  def list_feed_fetches_by_feed(feed_id) do
    Repo.all(from f in FeedFetch, where: f.feed_id == ^feed_id)
  end

  @doc """
  Gets a single feed_fetch.

  Raises `Ecto.NoResultsError` if the Feed fetch does not exist.

  ## Examples

      iex> get_feed_fetch!(123)
      %FeedFetch{}

      iex> get_feed_fetch!(456)
      ** (Ecto.NoResultsError)

  """
  def get_feed_fetch!(id), do: Repo.get!(FeedFetch, id)

  @doc """
  Creates a feed_fetch.

  ## Examples

      iex> create_feed_fetch(%{field: value})
      {:ok, %FeedFetch{}}

      iex> create_feed_fetch(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_feed_fetch(attrs \\ %{}) do
    %FeedFetch{}
    |> FeedFetch.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a feed_fetch.

  ## Examples

      iex> update_feed_fetch(feed_fetch, %{field: new_value})
      {:ok, %FeedFetch{}}

      iex> update_feed_fetch(feed_fetch, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_feed_fetch(%FeedFetch{} = feed_fetch, attrs) do
    feed_fetch
    |> FeedFetch.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a feed_fetch.

  ## Examples

      iex> delete_feed_fetch(feed_fetch)
      {:ok, %FeedFetch{}}

      iex> delete_feed_fetch(feed_fetch)
      {:error, %Ecto.Changeset{}}

  """
  def delete_feed_fetch(%FeedFetch{} = feed_fetch) do
    Repo.delete(feed_fetch)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking feed_fetch changes.

  ## Examples

      iex> change_feed_fetch(feed_fetch)
      %Ecto.Changeset{data: %FeedFetch{}}

  """
  def change_feed_fetch(%FeedFetch{} = feed_fetch, attrs \\ %{}) do
    FeedFetch.changeset(feed_fetch, attrs)
  end

  alias Consume.Feeds.FeedFetchData

  @doc """
  Returns the list of feed_fetch_data.

  ## Examples

      iex> list_feed_fetch_data()
      [%FeedFetchData{}, ...]

  """
  def list_feed_fetch_data do
    Repo.all(FeedFetchData)
  end

  @doc """
  Gets a single feed_fetch_data.

  Raises `Ecto.NoResultsError` if the Feed fetch data does not exist.

  ## Examples

      iex> get_feed_fetch_data!(123)
      %FeedFetchData{}

      iex> get_feed_fetch_data!(456)
      ** (Ecto.NoResultsError)

  """
  def get_feed_fetch_data!(id), do: Repo.get!(FeedFetchData, id)

  @doc """
  Creates a feed_fetch_data.

  ## Examples

      iex> create_feed_fetch_data(%{field: value})
      {:ok, %FeedFetchData{}}

      iex> create_feed_fetch_data(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_feed_fetch_data(attrs \\ %{}) do
    %FeedFetchData{}
    |> FeedFetchData.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Create a feed_fetch_data unless an identical one already exists
  """
  def upsert_feed_fetch_data(attrs \\ %{}) do
    %FeedFetchData{}
    |> FeedFetchData.changeset(attrs)
    |> Repo.insert(
      on_conflict: [set: [updated_at: DateTime.utc_now()]],
      conflict_target: [:feed_id, :sha256]
    )
  end

  @doc """
  Updates a feed_fetch_data.

  ## Examples

      iex> update_feed_fetch_data(feed_fetch_data, %{field: new_value})
      {:ok, %FeedFetchData{}}

      iex> update_feed_fetch_data(feed_fetch_data, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_feed_fetch_data(%FeedFetchData{} = feed_fetch_data, attrs) do
    feed_fetch_data
    |> FeedFetchData.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a feed_fetch_data.

  ## Examples

      iex> delete_feed_fetch_data(feed_fetch_data)
      {:ok, %FeedFetchData{}}

      iex> delete_feed_fetch_data(feed_fetch_data)
      {:error, %Ecto.Changeset{}}

  """
  def delete_feed_fetch_data(%FeedFetchData{} = feed_fetch_data) do
    Repo.delete(feed_fetch_data)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking feed_fetch_data changes.

  ## Examples

      iex> change_feed_fetch_data(feed_fetch_data)
      %Ecto.Changeset{data: %FeedFetchData{}}

  """
  def change_feed_fetch_data(%FeedFetchData{} = feed_fetch_data, attrs \\ %{}) do
    FeedFetchData.changeset(feed_fetch_data, attrs)
  end
end
