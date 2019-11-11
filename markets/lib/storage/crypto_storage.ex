defmodule Storage.CryptoStorage do
    # TODO add GenServer

    defp storage_path(file) when is_bitstring(file) do
        "storage/crypto/" <> file
    end

    defp initial_assets_file do
        "crypto_assets.json"
    end

    defp state_file do
        "crypto_data.json"
    end

    defp default_assets do
        %{
            bitcoin: "bitcoin",
            ethereum: "ethereum",
            monero: "monero",
            litecoin: "litecoin",
            cardano: "cardano"
        }
    end

    defp storage_get(file) when is_bitstring(file) do
        File.read(storage_path(file))
    end

    defp storage_write(file, content) when is_bitstring(file) and is_map(content) do
        with :ok <- File.mkdir_p(Path.dirname(storage_path(file))) do
            File.write(storage_path(file), Jason.encode!(content))
        end
    end

    def get_initial_assets_list do
        {status, assets} = storage_get(initial_assets_file())
        case status == :error do
            :true -> default_assets()
            _ -> Jason.decode!(assets)
        end
    end

    def set_initial_assets_list(assets) when is_map(assets) do
        case assets == %{} do
            :true -> storage_write(initial_assets_file(), default_assets())
            _ -> storage_write(initial_assets_file(), assets)
        end
    end

    def get_state do
        {status, state} = storage_get(state_file())
        case status == :error do
            :true -> %{}
            _ -> Jason.decode!(state)
        end
    end

    def set_state(content) do
        storage_write(state_file(), content)
    end
end
