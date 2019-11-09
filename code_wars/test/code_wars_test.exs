defmodule CodeWarsTest do
  use ExUnit.Case
  doctest CodeWars

  test "greets the world" do
    assert CodeWars.hello() == :world
  end
end
