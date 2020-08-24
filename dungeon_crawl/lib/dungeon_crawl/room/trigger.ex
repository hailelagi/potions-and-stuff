# CREATING BEHAVIOURS
defmodule DungeonCrawl.Room.Trigger do
  # function rule
  @callback run(Character.t(), Action.t()) :: {Character.t(), atom}
end
