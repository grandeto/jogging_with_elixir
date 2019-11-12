defmodule Controllers.CryptoController do
    alias Services.CryptoMarketService, as: CryptoMarketService
    alias Storage.CryptoStorage, as: CryptoStorage

    def show_current_state do
        CryptoMarketService.index
    end

    def update_news(latest_news) do
        CryptoMarketService.update_news(latest_news)
    end

    def add_new_asset(asset) do
        CryptoMarketService.new(asset)
    end

    def get_initial_assets_list do
        CryptoStorage.get_initial_assets_list
    end

    def set_initial_assets_list(map) do
        CryptoStorage.set_initial_assets_list(map)
    end
end
