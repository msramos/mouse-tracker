defmodule Tracker.Events do
  def position(x, y) do
    KafkaEx.produce("position", 0, <<x::16, y::16>>)
    # TrackerWeb.ClientCanvas.send_position(x, y)
  end

  def click(x, y) do
    KafkaEx.produce("click", 0, <<x::16, y::16>>)
    # TrackerWeb.ClientCanvas.send_click(x, y)
  end
end
