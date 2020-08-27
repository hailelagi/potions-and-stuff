defmodule DungeonCrawl.Room.Triggers.Exit do
  @behaviour DungeonCrawl.Room.Trigger

  @impl DungeonCrawl.Room.Trigger
  def run(character, _), do: {character, :exit}
end
