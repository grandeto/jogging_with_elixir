defmodule CryptoController do
    def update_news(latest_news) do
        CryptoMarketService.update_news(latest_news)
    end

    def get_initial_assets_list do
        CryptoStorage.get_initial_assets_list
    end

    def set_initial_assets_list(map) do
        CryptoStorage.set_initial_assets_list(map)
    end
end
