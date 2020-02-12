defmodule AppBackTest do
  use ExUnit.Case
  doctest AppBack

  test "greets the world" do
    assert AppBack.hello() == :world
  end
end
