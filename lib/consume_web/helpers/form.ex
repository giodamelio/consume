defmodule ConsumeWeb.Helpers.Form do
  alias Phoenix.HTML
  import Phoenix.LiveView.Helpers

  import ConsumeWeb.ErrorHelpers

  def input(assigns, form, field) do
    ~H"""
    <div class="field">
      <%= HTML.Form.label form, field, class: "label" %>
      <div class="control">
        <%= HTML.Form.text_input form, field, class: "input" %>
      </div>
      <%= error_tag form, field %>
    </div>
    """
  end

  def button_link(text, path) do
    HTML.Link.link(text, class: "button", to: path)
  end

  def button_link(text, color, path) do
    HTML.Link.link(text, class: ["button", "is-#{color}"], to: path)
  end

  def submit(text) do
    HTML.Form.submit(text, class: "button")
  end

  def submit(text, color) do
    HTML.Form.submit(text, class: "button is-#{color}")
  end
end
