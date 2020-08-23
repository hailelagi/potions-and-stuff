# CREATING BEHAVIOURS
defmodule DungeonCrawl.Room.Trigger do
  # function rule
  @callback run(character :: any, action :: any) :: any
end
