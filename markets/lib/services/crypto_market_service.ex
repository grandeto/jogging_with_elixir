defmodule Services.CryptoMarketService do

    alias Storage.CryptoStorage, as: CryptoStorage
    use GenServer

    defstruct state: %{}, save_state: :true

    def init(init_args) do
        {:ok, init_args}
    end

    def start_link(state) when is_map(state) do
        GenServer.start_link(__MODULE__, state, name: __MODULE__)
    end

    def index do
        GenServer.call(__MODULE__, {:index})
    end

    def new(asset) when is_bitstring(asset) do
        GenServer.call(__MODULE__, {:new, asset})
    end

    def show(asset) when is_bitstring(asset) do
        GenServer.call(__MODULE__, {:show, asset})
    end

    def update_news(latest_news) when is_map(latest_news) do
        GenServer.call(__MODULE__, {:update_news, latest_news})
        #GenServer.cast(__MODULE__, {:update_news, latest_news})
    end

    def delete(asset) when is_bitstring(asset) do
        # TODO
    end

    def handle_call({:index}, _from, state) do
        {:reply, state, state}
    end

    def handle_call({:new, asset}, _from, state) do
        current_assets = CryptoStorage.get_initial_assets_list
        new_assets = Map.update(current_assets, asset, asset, fn _ -> asset end)
        CryptoStorage.set_initial_assets_list(new_assets)
        {:stop, :new_asset_added, state}
    end

    def handle_call({:show, asset}, _from, state) do
        {:reply, state[asset], state}
    end

    def handle_call({:update_news, latest_news}, _from, state) do
        state = has_coin?(latest_news, state)
        {:reply, state, state}
    end

    # def handle_cast({:update_news, latest_news}, state) do
    #     new_state = has_coin?(latest_news, state)
    #     {:noreply, new_state}
    # end

    defp has_coin?(latest_news, state) when is_map(latest_news) do
        has_coin?(Map.to_list(latest_news), state)
    end

    defp has_coin?([], new_state), do: new_state

    defp has_coin?([{coin, new_val} | rest], state) do
        has_coin?(rest,
            Map.update(state, coin,
                %{
                    "new_value" => new_val,
                    "old_value" => :nil,
                    "updated_at" => DateTime.utc_now
                },
                fn %{"new_value" => old_val} ->
                    %{
                        "new_value" => new_val,
                        "old_value" => old_val,
                        "updated_at" => DateTime.utc_now
                    }
                end))
    end
end
