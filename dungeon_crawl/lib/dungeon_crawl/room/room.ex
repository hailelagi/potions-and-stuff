defmodule DungeonCrawl.Room do
  @moduledoc """
  data structure representing a "room"
  a room has "actions" borrowed
  """
  alias DungeonCrawl.Room, as: Room
  alias DungeonCrawl.Room.Triggers, as: Triggers
  import DungeonCrawl.Room.Action

  defstruct name: nil, description: nil, actions: [], trigger: nil, probability: 0

  def all,
    do: [
      %Room{
        name: :exit,
        description: "You can see a small light from a crack in the walls",
        actions: [forward()],
        trigger: Triggers.Exit,
        probability: [:exit]
      },
    %Room{
        name: :goblin,
        description: "You can see an enemy blocking your path",
        actions: [forward()],
        trigger: Triggers.Enemy,
        probability: [:goblin, :goblin, :goblin, :goblin, :goblin]
      },
    %Room{
        name: :ogre,
        description: "Something moves around in the dark, what do you do?",
        actions: [forward()],
        trigger: Triggers.Enemy,
        probability: [:ogre, :ogre, :ogre]
      },
    ]
end
