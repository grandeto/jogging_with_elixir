defmodule Controllers.CryptoController do
    alias Services.CryptoMarketService, as: CryptoMarketService
    alias Storage.CryptoStorage, as: CryptoStorage

    def show_current_state do
        CryptoMarketService.index
    end

    def add_new_asset(asset) when is_bitstring(asset) do
        CryptoMarketService.new(asset)
    end

    def show_asset(asset) when is_bitstring(asset) do
        CryptoMarketService.show(asset)
    end

    def update_news(latest_news) when is_map(latest_news) do
        CryptoMarketService.update_news(latest_news)
    end

    def delete_asset(asset) when is_bitstring(asset) do
        CryptoMarketService.delete(asset)
    end

    def get_initial_assets_list do
        CryptoStorage.get_initial_assets_list
    end

    def set_initial_assets_list(map) when is_map(map) do
        CryptoStorage.set_initial_assets_list(map)
    end

    def get_state do
        CryptoStorage.get_state
    end

    def set_state(state) when is_map(state) do
        CryptoStorage.set_state(state)
    end

    def get_new_asset_obj do
        CryptoStorage.new_asset_obj
    end
end
