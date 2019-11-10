# Read file, split by line and get random line
defmodule TweetsElixir.FileReader do
    @doc """
    iex> TweetsElixir.FileReader.get_strings_to_tweet("priv/sample.txt")
    "ABC"
    """
    def get_strings_to_tweet(path) do
        File.read!(path)
        |> pick_string
    end

    def pick_string(str) do
        str
        |> String.split("\n")
        |> Enum.map(&String.trim/1)
        |> Enum.filter(&String.length(&1) <= 140)
        |> Enum.random()
    end
end