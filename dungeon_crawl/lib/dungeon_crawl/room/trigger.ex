# CREATING CONTRACTS and BEHAVIOURS
# pg 163
defmodule DungeonCrawl.Room.Trigger do
  @callback run(character :: any, action :: any) :: any
end
