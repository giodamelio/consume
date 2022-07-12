defmodule ConsumeWeb.Helpers.View do
  @moduledoc false

  use Phoenix.HTML
  import Phoenix.LiveView.Helpers

  def custom_datetime_select(form, field, opts \\ []) do
    builder = fn b ->
      assigns = %{b: b}
      class = [class: "datetime_select"]

      ~H"""
      <%= @b.(:day, class) %> / <%= @b.(:month, class) %> / <%= @b.(:year, class) %>
      &mdash;
      <%= @b.(:hour, class) %> : <%= @b.(:minute, class) %>
      """
    end

    datetime_select(form, field, [builder: builder] ++ opts)
  end

  def truncate(string) do
    (string
     |> String.slice(0, 20)
     |> String.trim()) <> "..."
  end
end
