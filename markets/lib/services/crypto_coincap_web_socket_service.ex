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

    def child_spec(_) do
        %{
            id: Services.CryptoCoincapWebSocketService,
            start: {
                Services.CryptoCoincapWebSocketService,
                :start_link,
                [generate_url(), "Success"]
            }
        }
    end

    def start_link(url, msg) do
        WebSockex.start_link(url, __MODULE__, msg)
    end

    def handle_frame({_type, news}, msg) do
        news = Jason.decode!(news)
        CryptoController.update_news(news)
        {:ok, msg}
    end

    # def handle_cast({:send, {type, news} = frame}, msg) do
    #     IO.puts "Sending #{type} frame with payload: #{news}"
    #     {:reply, frame, msg}
    # end
end
