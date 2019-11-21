defmodule Tracker.PositionConsumerGroup do
  use KafkaEx.GenConsumer

  alias KafkaEx.Protocol.Fetch.Message

  require Logger

  def handle_message_set(message_set, state) do
    for %Message{value: message} <- message_set do
      <<x::16, y::16>> = message
      TrackerWeb.ClientCanvas.send_position(x, y)
    end

    {:async_commit, state}
  end
end
