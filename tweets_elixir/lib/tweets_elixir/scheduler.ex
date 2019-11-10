defmodule TweetsElixir.Scheduler do
    use Quantum.Scheduler,
      otp_app: :tweets_elixir

    def schedule_file(filepath) do
        # send result from FileReader to TweetGenServer
        TweetsElixir.FileReader.get_strings_to_tweet(filepath)
        |> TweetsElixir.TweetServer.tweet
    end
  end