defmodule DungeonCrawl.Room do
  @moduledoc """
  data structure representing a "room"
  a room has "actions" borrowed
  """
  alias DungeonCrawl.Room, as: Room
  alias DungeonCrawl.Room.Triggers, as: Triggers
  import DungeonCrawl.Room.Action

  defstruct description: nil, actions: [], trigger: nil

  def all,
    do: [
      %Room{
        description: "You can see a small light from a crack in the walls",
        actions: [forward()],
        trigger: Triggers.Exit
      }
    ]
end
