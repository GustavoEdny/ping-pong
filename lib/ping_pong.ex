defmodule PingPong do
  @count_limit 10

  def main do
    lisa = self()
    bob = PingPong |> Task.start(:listen, []) |> elem(1)

    IO.puts "lisa #{inspect lisa}"
    IO.puts "lisa #{inspect bob}"

    send_to(bob, :ping, 1)
    listen()
  end

  def listen do
    receive do
      {_sender, _message, @count_limit} ->
        IO.puts "Call finished."
        listen()

      {sender, message, count} ->
        send_to(sender, reply(message), count + 1)
        listen()
    after
      1_000 -> IO.puts "Timing out call #{inspect process_pid()}"
    end
  end

  def send_to(process_id, action, count) do
    IO.puts "Called #{count} times. send_to #{inspect process_id} #{inspect action}"
    send(process_id, {process_pid(), action, count})
  end

  def reply(message) do
    case message do
      :ping -> :pong
      _____ -> :ping
    end
  end

  defp process_pid, do: self()
end
