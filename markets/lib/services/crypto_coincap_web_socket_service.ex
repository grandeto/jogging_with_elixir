defmodule Services.CryptoCoincapWebSocketService do
    alias Controllers.CryptoController, as: CryptoController
    use WebSockex

    defp generate_url do
        base_url = "wss://ws.coincap.io/prices?assets="
        url = CryptoController.get_initial_assets_list
        |> Map.values()
        |> Enum.reduce(base_url, fn x, acc -> acc <> x <> "," end)
        String.slice(url, 0, String.length(url) - 1)
    end

    def init(init_args) do
        {:ok, init_args}
    end

    def start_link(_) do
        WebSockex.start_link(generate_url(), __MODULE__, [])
    end

    def handle_frame({_type, news}, state) do
        news = Jason.decode!(news)
        CryptoController.update_news(news)
        {:ok, state}
    end

    # def handle_cast({:send, {type, news} = frame}, state) do
    #     IO.puts "Sending #{type} frame with payload: #{news}"
    #     {:reply, frame, state}
    # end
end
