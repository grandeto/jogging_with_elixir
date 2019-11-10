defmodule TweetsElixir.MixProject do
  use Mix.Project

  def project do
    [
      app: :tweets_elixir,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      # Runn additional mixes on start
      extra_applications: [:logger, :quantum, :timex, :extwitter],
      mod: {TweetsElixir.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:credo, "~> 1.1"},
      {:quantum, "~> 2.3"},
      {:timex, "~> 3.0"},
      {:extwitter, "~> 0.9.6"},
      {:oauth, github: "tim/erlang-oauth"},
      {:mock, "~> 0.3.3"},
      {:mix_test_watch, "~> 0.9.0"}
    ]
  end
end
