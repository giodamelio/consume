defmodule ConsumeWeb.Helpers.Form do
  alias Phoenix.HTML
  import Phoenix.LiveView.Helpers

  import ConsumeWeb.ErrorHelpers

  def text_input(assigns, form, field) do
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

  def number_input(assigns, form, field) do
    ~H"""
    <div class="field">
      <%= HTML.Form.label form, field, class: "label" %>
      <div class="control">
        <%= HTML.Form.number_input form, field, class: "input" %>
      </div>
      <%= error_tag form, field %>
    </div>
    """
  end

  def button_link(text, path, opts \\ []) do
    classes = [
      "button"
    ]

    classes =
      if opts[:color] do
        classes ++ ["is-#{opts[:color]}"]
      else
        classes
      end

    classes =
      if opts[:size] do
        classes ++ ["is-#{opts[:size]}"]
      else
        classes
      end

    HTML.Link.link(text, opts ++ [class: classes, to: path])
  end

  def submit(text, opts \\ []) do
    classes = [
      "button"
    ]

    classes =
      if opts[:color] do
        classes ++ ["is-#{opts[:color]}"]
      else
        classes
      end

    HTML.Form.submit(text, opts ++ [class: classes])
  end
end
