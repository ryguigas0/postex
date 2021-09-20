defmodule Postex.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Postex.Repo,
      # Start the Telemetry supervisor
      PostexWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Postex.PubSub},
      # Start the Endpoint (http/https)
      PostexWeb.Endpoint
      # Start a worker by calling: Postex.Worker.start_link(arg)
      # {Postex.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Postex.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    PostexWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
