defmodule TrackerWeb.TrackerChannel do
  use TrackerWeb, :channel

  alias TrackerWeb.Endpoint
  alias Tracker.Events

  def join("tracker", _params, socket) do
    {:ok, socket}
  end

  def handle_in("position", %{"x" => x, "y" => y}, socket) do
    Events.position(x, y)
    {:reply, :ok, socket}
  end

  def handle_in("click", %{"x" => x, "y" => y}, socket) do
    Events.click(x, y)
    {:reply, :ok, socket}
  end
end
