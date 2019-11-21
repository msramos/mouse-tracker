defmodule TrackerWeb.ClientCanvas do
  alias TrackerWeb.Endpoint

  def send_position(x, y) do
    Endpoint.broadcast!("tracker", "event:position", %{x: x, y: y})
  end

  def send_click(x, y) do
    Endpoint.broadcast!("tracker", "event:click", %{x: x, y: y})
  end
end
