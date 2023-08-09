defmodule BasicChatTest do
  use ExUnit.Case
  doctest BasicChat

  test "greets the world" do
    assert BasicChat.hello() == :world
  end
end
