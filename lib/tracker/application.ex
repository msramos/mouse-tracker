defmodule Tracker.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      TrackerWeb.Endpoint,
      supervisor(KafkaEx.ConsumerGroup, position_consumer_group(),
        id: Tracker.PositionConsumerGroup
      ),
      supervisor(KafkaEx.ConsumerGroup, click_consumer_group(), id: Tracker.ClickConsumerGroup)
    ]

    opts = [strategy: :one_for_one, name: Tracker.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    TrackerWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp position_consumer_group do
    [
      Tracker.PositionConsumerGroup,
      "tracker-position",
      ["position"],
      [
        heartbeat_interval: 1_000,
        commit_interval: 1_000
      ]
    ]
  end

  defp click_consumer_group do
    [
      Tracker.ClickConsumerGroup,
      "tracker-click",
      ["click"],
      [
        heartbeat_interval: 1_000,
        commit_interval: 1_000
      ]
    ]
  end
end
