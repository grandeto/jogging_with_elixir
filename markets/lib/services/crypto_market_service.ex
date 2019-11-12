defmodule Services.CryptoMarketService do
    # TODO Add remove assets, List all assets data, List single asset data

    alias Storage.CryptoStorage, as: CryptoStorage
    use GenServer

    defstruct state: %{}, save_state: :true

    def init(init_args) do
        {:ok, init_args}
    end

    def child_spec(_) do
        %{
            id: Services.CryptoMarketService,
            start: {
                Services.CryptoMarketService,
                :start_link,
                [CryptoStorage.get_state]
            }
        }
    end

    def start_link(state) when is_map(state) do
        IO.inspect(state)
        GenServer.start_link(__MODULE__, state, name: __MODULE__)
    end

    def index do
        GenServer.call(__MODULE__, {:index})
    end

    def update_news(latest_news) when is_map(latest_news) do
        GenServer.call(__MODULE__, {:update_news, latest_news})
        #GenServer.cast(__MODULE__, {:update_news, latest_news})
    end

    def new(asset) when is_bitstring(asset) do
        GenServer.call(__MODULE__, {:new, asset})
    end

    def show(id) do
        IO.puts(id)
    end

    def delete(id) do
        IO.puts(id)
    end

    def handle_call({:index}, _from, state) do
        IO.inspect(state)
        {:reply, state, state}
    end

    def handle_call({:update_news, latest_news}, _from, state) do
        state = has_coin?(latest_news, state)
        {:reply, state, state}
    end

    def handle_call({:new, asset}, _from, state) do
        current_assets = CryptoStorage.get_initial_assets_list
        new_assets = Map.update(current_assets, asset, asset, fn _ -> asset end)
        CryptoStorage.set_initial_assets_list(new_assets)
        {:stop, :new_asset, state}
    end

    def handle_cast({:update_news, latest_news}, state) do
        new_state = has_coin?(latest_news, state)
        {:noreply, new_state}
    end

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
