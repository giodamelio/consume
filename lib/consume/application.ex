defmodule Consume.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Consume.Repo,
      # Start the Telemetry supervisor
      ConsumeWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Consume.PubSub},
      # Start the Endpoint (http/https)
      ConsumeWeb.Endpoint,
      # Start the fetcher GenServer
      Consume.Feeds.Fetcher
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Consume.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ConsumeWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
