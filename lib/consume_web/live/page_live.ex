defmodule ConsumeWeb.PageLive do
  @moduledoc """
  Homepage with quicklinks and live stats
  """

  use ConsumeWeb, :live_view

  def mount(_params, _session, socket) do
    if connected?(socket) do
      setup_tick()
    end

    {:ok, assign(socket, :count, 0)}
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
      <p><%= @count %></p>
    </section>
    """
  end

  def handle_info(:tick, socket) do
    setup_tick()

    {:noreply, assign(socket, :count, socket.assigns.count + 1)}
  end

  defp setup_tick() do
    Process.send_after(self(), :tick, 1000)
  end
end
