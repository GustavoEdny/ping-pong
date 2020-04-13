defmodule PingPongTest do
  use ExUnit.Case
  doctest PingPong

  test "reply returns :pong when receive :ping" do
    assert PingPong.reply(:ping) == :pong
  end

  test "reply returns :ping when receive any value" do
    assert PingPong.reply(:pong) == :ping
    assert PingPong.reply("pong") == :ping
    assert PingPong.reply([]) == :ping
  end
end
