defmodule CryptoWebSocket do
    use WebSockex

    defp generate_url do
        base_url = "wss://ws.coincap.io/prices?assets="
        url = CryptoController.get_initial_assets_list
        |> Map.values()
        |> Enum.reduce(base_url, fn x, acc -> acc <> x <> "," end)
        String.slice(url, 0, String.length(url) - 1)
    end

    def child_spec(_) do
        %{
            id: CryptoWebSocket,
            start: {
                CryptoWebSocket,
                :start_link,
                [generate_url(), []]
            }
        }
    end

    def start_link(url, state) do
        WebSockex.start_link(url, __MODULE__, state)
    end

    def handle_frame({_type, news}, state) do
        news = Jason.decode!(news)
        CryptoController.update_news(news)
        {:ok, state}
    end

    def handle_cast({:send, {type, msg} = frame}, state) do
        IO.puts "Sending #{type} frame with payload: #{msg}"
        {:reply, frame, state}
    end
end
