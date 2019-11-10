defmodule TweetsElixirTest do
  use ExUnit.Case
  doctest TweetsElixir

  test "greets the world" do
    assert TweetsElixir.hello() == :world
  end
end
