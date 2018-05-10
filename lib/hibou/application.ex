defmodule Hibou.Application do
  use Application

  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    children =
      case Application.get_env(:hibou, HibouWeb.Endpoint) do
        nil ->
          []

        _ ->
          [
            # Start the Ecto repository
            supervisor(Hibou.Repo, []),
            # Start the endpoint when the application starts
            supervisor(HibouWeb.Endpoint, [])
            # Start your own worker by calling: Hibou.Worker.start_link(arg1, arg2, arg3)
            # worker(Hibou.Worker, [arg1, arg2, arg3]),
          ]
      end

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Hibou.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    HibouWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
