defmodule CryptoController do
    def create(data) do
        CryptoMarket.new(data)
    end

    def get_initial_assets_list do
        CryptoStorage.get_initial_assets_list
    end
end
