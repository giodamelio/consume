defmodule ConsumeWeb.PageLive do
  @moduledoc """
  Homepage with quicklinks and live stats
  """

  use ConsumeWeb, :live_view

  alias Consume.Feeds.Fetcher

  def mount(_params, _session, socket) do
    if connected?(socket) do
      setup_tick()
    end

    {:ok, update_state_from_fetcher(socket)}
  end

  def render(assigns) do
    ~H"""
    <h1>Consume</h1>

    <section>
      <h2>Quick Links:</h2>
      <ul class="list-disc">
        <%= if function_exported?(Routes, :live_dashboard_path, 2) do %>
          <li><%= link "LiveDashboard", to: Routes.live_dashboard_path(@socket, :home) %></li>
        <% end %>
        <li><%= link "Feeds", to: Routes.feed_path(@socket, :index) %></li>
        <li><%= link "Feed Fetches", to: Routes.feed_fetch_path(@socket, :index) %></li>
      </ul>
    </section>

    <section>
      <h2>Stats:</h2>

      <section>
        <h3>Fetcher:</h3>
        <p>Enabled: <%= @enabled %></p>
        <p>Ticks Since Started: <%= @ticks %></p>
        <button class="inline" phx-click="enable">Enable</button>
        <button class="inline" phx-click="disable">Disable</button>
      </section>
    </section>
    """
  end

  def handle_info(:tick, socket) do
    setup_tick()
    {:noreply, update_state_from_fetcher(socket)}
  end

  def handle_event("enable", _payload, socket) do
    :enabled = Fetcher.enable()
    {:noreply, update_state_from_fetcher(socket)}
  end

  def handle_event("disable", _payload, socket) do
    :disabled = Fetcher.disable()
    {:noreply, update_state_from_fetcher(socket)}
  end

  defp setup_tick() do
    Process.send_after(self(), :tick, 1000)
  end

  defp update_state_from_fetcher(socket) do
    assign(socket, ticks: Fetcher.ticks_since_started(), enabled: Fetcher.enabled?())
  end
end
