defmodule Consume.Fetcher.Fetchers.RSS2_0Fetcher do
  @behaviour Consume.Fetcher.Fetcher

  @impl true
  def name(), do: "rss2_0"

  @impl true
  def fetch(uri) do
    with {:ok, response} <- Tesla.get(uri),
         {:ok, feed, _} <- FeederEx.parse(response.body) do
      feed_items =
        feed.entries
        |> Enum.map(fn entry ->
          %{
            version: 1,
            hash: :crypto.hash(:sha256, entry.id),
            data: :erlang.term_to_binary(entry)
          }
        end)

      {:ok, feed_items}
    else
      {:error, err} -> {:error, err}
    end
  end

  @impl true
  def valid_id?("https://" <> _rest), do: true
  def valid_id?("http://" <> _rest), do: true
  def valid_id?(_url), do: false
end
