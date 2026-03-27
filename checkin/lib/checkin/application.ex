defmodule Checkin.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      CheckinWeb.Telemetry,
      Checkin.Repo,
      {DNSCluster, query: Application.get_env(:checkin, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Checkin.PubSub},
      # Start a worker by calling: Checkin.Worker.start_link(arg)
      # {Checkin.Worker, arg},
      # Start to serve requests, typically the last entry
      CheckinWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Checkin.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CheckinWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
