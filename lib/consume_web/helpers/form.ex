defmodule ConsumeWeb.Helpers.Form do
  use Phoenix.HTML
  import Phoenix.LiveView.Helpers

  import ConsumeWeb.ErrorHelpers

  def input(assigns, form, field) do
    ~H"""
    <div class="field">
      <%= label form, field, class: "label" %>
      <div class="control">
        <%= text_input form, field, class: "input" %>
      </div>
      <%= error_tag form, field %>
    </div>
    """
  end

  def submit(text) do
    submit(text, class: "button is-primary")
  end
end
