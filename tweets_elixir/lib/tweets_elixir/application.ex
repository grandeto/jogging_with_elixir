defmodule TweetsElixir.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Starts a worker by calling: TweetsElixir.Worker.start_link(arg)
      # {TweetsElixir.Worker, arg}
      TweetsElixir.Scheduler,
      TweetsElixir.TweetServer
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TweetsElixir.Supervisor]
    
    # Starts children modules
    process = Supervisor.start_link(children, opts)

    # Needed by supervisor
    process
  end
end
