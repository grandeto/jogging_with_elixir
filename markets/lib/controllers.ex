defmodule CryptoController do
    def create(data) do
        CryptoMarket.new(data)
    end
end
