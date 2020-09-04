defmodule DungeonCrawl.CLI.RoomActionsChoice do
  @moduledoc """
  Room logic controller processes room actions, by borrowing helpers
  from base_commands returns the room and the action chosen
  """
  alias Mix.Shell.IO, as: Shell
  import DungeonCrawl.CLI.BaseCommands

  def start(room) do
    # A single random room map
    # list of action functions
    room_actions = room.actions

    Shell.info(room.description())

    chosen_action = ask_for_option(room_actions)

    {room, chosen_action}
  end
end
