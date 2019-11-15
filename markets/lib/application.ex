defmodule MarketsApplication do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  alias Services.CryptoCoincapWebSocketService, as: CryptoCoincapWebSocketService
  alias Services.CryptoMarketService, as: CryptoMarketService

  use Application

  def start(_type, _args) do
    children = [
        CryptoMarketService,
        CryptoCoincapWebSocketService
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_all, name: Markets.Supervisor]

    # Starts children modules
    process = Supervisor.start_link(children, opts)

    # Needed by supervisor
    process
  end
end
