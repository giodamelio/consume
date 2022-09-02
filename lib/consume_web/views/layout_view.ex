defmodule ConsumeWeb.LayoutView do
  use ConsumeWeb, :view

  def nav_link(conn, text, path) do
    # Highlight the active page
    active_class =
      case Map.fetch(conn, :request_path) do
        {:ok, ^path} ->
          ["is-active"]

        _ ->
          []
      end

    link(text,
      class: ["navbar-item"] ++ active_class,
      to: path
    )
  end

  # Phoenix LiveDashboard is available only in development by default,
  # so we instruct Elixir to not warn if the dashboard route is missing.
  @compile {:no_warn_undefined, {Routes, :live_dashboard_path, 2}}
end
