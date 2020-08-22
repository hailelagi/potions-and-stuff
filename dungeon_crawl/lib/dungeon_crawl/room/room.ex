defmodule DungeonCrawl.Room do
  @moduledoc """
  data structure representing a "room"
  a room has "actions" borrowed
  """
  alias DungeonCrawl.Room, as: Room
  import DungeonCrawl.Room.Action

  defstruct description: nil, actions: []

  def all,
    do: [
      %Room{
        description: "You found a quiet place. Looks safe for a little nap.",
        actions: [forward(), rest()]
      }
    ]
end
