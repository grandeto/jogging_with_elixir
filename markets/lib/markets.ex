defmodule CryptoMarketService do

    def update_news(latest_news) do
        has_coin?(latest_news, CryptoStorage.get_state)
        |> CryptoStorage.set_state()
    end

    def has_coin?(latest_news, state) when is_map(latest_news) do
        has_coin?(Map.to_list(latest_news), state)
    end

    def has_coin?([], new_state), do: new_state

    def has_coin?([{coin, new_val} | rest], state) do
        has_coin?(rest,
            Map.update(state, coin,
                %{
                    "new_value" => new_val,
                    "old_value" => :nil,
                    "updated_at" => DateTime.utc_now
                },
                fn %{"new_value" => old_val} = coin_data ->
                    %{
                        "new_value" => new_val,
                        "old_value" => old_val,
                        "updated_at" => DateTime.utc_now
                    }
                end))
    end

    # %{"bitcoin" => %{new_value: 123, old_value: 111, updated_at: time}}

    def index do
        #IO.inspect(data)
    end

    def new(data) do
        #IO.inspect(data)
    end

    def create(data) do
        #IO.inspect(data)
    end

    def show(id) do
        #IO.inspect(data)
    end

    def update(id) do
        #IO.inspect(data)
    end

    def delete(id) do
        #IO.inspect(data)
    end
end
