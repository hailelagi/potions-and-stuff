# CREATING BEHAVIOURS
defmodule DungeonCrawl.Room.Trigger do
  alias DungeonCrawl.Character, as: Character
  alias DungeonCrawl.Room.Action, as: Action

  # function(rule) signature
  # callback references custom type "t"
  # implemented as a behaviour in exit
  @callback run(Character.t(), Action.t()) :: {Character.t(), atom}
end
