defmodule TweetsElixir.Tweet do
    # Sends tweets (a extweet mix should be used instead of IO.puts)
    def send(str) do
        # ExTwitter.configure(:process, [
        #     consumer_key: System.get_env("TWEETS_ELIXIR_CONSUMER_KEY"),
        #     consumer_secret: System.get_env("TWEETS_ELIXIR_CONSUMER_SECRET"),
        #     access_token: System.get_env("TWEETS_ELIXIR_ACCESS_TOKEN"),
        #     access_token_secret: System.get_env("TWEETS_ELIXIR_ACCESS_TOKEN_SECRET")
        # ])
        # ExTwitter.update(str)
        IO.puts(str)
    end
end