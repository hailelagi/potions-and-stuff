defmodule DungeonCrawl.Room do
  alias DungeonCrawl.Room, as: Room
  import DungeonCrawl.Room.Action

  def struct(description, actions: [])

  def all,
    do: [
      %Room{
        description: "You found a quiet place. Looks safe for a little nap.",
        actions: [forward(), rest()]
      }
    ]
end
