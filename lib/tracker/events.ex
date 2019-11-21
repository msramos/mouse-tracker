defmodule Tracker.Events do
  def position(x, y) do
    # Remover a linha abaixo e enviar para o Kafka
    TrackerWeb.ClientCanvas.send_position(x, y)
  end

  def click(x, y) do
    # Remover a linha abaixo e enviar para o Kafka
    TrackerWeb.ClientCanvas.send_click(x, y)
  end
end
