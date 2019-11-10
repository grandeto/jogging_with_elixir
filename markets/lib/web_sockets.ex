defmodule CryptoWebSocket do
    use WebSockex

    def start_link(state) do
        WebSockex.start_link("wss://ws.coincap.io/prices?assets=bitcoin,ethereum,monero,litecoin", __MODULE__, state)
    end

    def handle_frame({_type, msg}, state) do
        news = Jason.decode!(msg)
        CryptoController.create(news)
        {:ok, state}
    end

    def handle_cast({:send, {type, msg} = frame}, state) do
        IO.puts "Sending #{type} frame with payload: #{msg}"
        {:reply, frame, state}
    end
end
