defmodule Services.CryptoMarketService do
    # TODO Add remove assets, List all assets data, List single asset data

    alias Storage.CryptoStorage, as: CryptoStorage
    use GenServer

    defstruct state: %{}, save_state: :true

    def init(init_arg) do
        {:ok, init_arg}
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

    def start_link(state) do
        GenServer.start_link(__MODULE__, state, name: __MODULE__)
    end

    def update_news(latest_news) do
        GenServer.call(__MODULE__, {:update_news, latest_news})
        #GenServer.cast(__MODULE__, {:update_news, latest_news})
    end

    def index do
        #IO.inspect(data)
    end

    def new(data) do
        IO.puts(data)
    end

    def show(id) do
        IO.puts(id)
    end

    def delete(id) do
        IO.puts(id)
    end

    def handle_call({:update_news, latest_news}, _from, state) do
        new_state = has_coin?(latest_news, state)
        IO.inspect(new_state)
        {:reply, new_state, state}
    end

    def handle_cast({:update_news, latest_news}, state) do
        new_state = has_coin?(latest_news, state)
        IO.inspect(new_state)
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
                fn %{"new_value" => old_val} = coin_data ->
                    %{
                        "new_value" => new_val,
                        "old_value" => old_val,
                        "updated_at" => DateTime.utc_now
                    }
                end))
    end
end
