defmodule Consume.Fetcher.HttpGetFetcher do
  @behaviour Consume.Fetcher

  @impl true
  def name(), do: "http_get"

  @impl true
  def fetch(uri) do
    case Tesla.get(uri) do
      {:ok, response} ->
        hash = :crypto.hash(:sha256, response.body)
        {:ok, {hash, response.body}}

      {:error, error} ->
        {:error, error.reason}
    end
  end

  @impl true
  def valid_id?("https://" <> _rest), do: true
  def valid_id?("http://" <> _rest), do: true
  def valid_id?(_url), do: false
end
