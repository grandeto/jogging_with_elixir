defmodule TweetsElixir.TweetServer do
    use GenServer

    # Start TweetServer child on app init
    def start_link(_) do
        # Hardcode the name of the GenServer to :tweet_server
        GenServer.start_link(__MODULE__, :ok, name: :tweet_server)
    end

    
    def init(:ok) do
        {:ok, %{}}
    end

    # Catch the cast and call Tweet module to execute it
    def handle_cast({:tweet, tweet}, _) do
        TweetsElixir.Tweet.send(tweet)
        {:noreply, %{}}
    end

    def tweet(tweet) do
        GenServer.cast(:tweet_server, {:tweet, tweet})
    end
end