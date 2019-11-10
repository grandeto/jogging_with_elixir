import Config

config :logger, level: :debug

config :tweets_elixir, TweetsElixir.Scheduler,
  jobs: [
    # Every minute {module, function, arg}
    {"* * * * *",      {TweetsElixir.Scheduler, :schedule_file, ["priv/sample.txt"]}},
    # # Every 15 minutes
    # {"*/15 * * * *",   fn -> System.cmd("rm", ["/tmp/tmp_"]) end},
    # # Runs on 18, 20, 22, 0, 2, 4, 6:
    # {"0 18-6/2 * * *", fn -> :mnesia.backup('/var/backup/mnesia') end},
    # # Runs every midnight:
    # {"@daily",         {Backup, :backup, []}}
  ]