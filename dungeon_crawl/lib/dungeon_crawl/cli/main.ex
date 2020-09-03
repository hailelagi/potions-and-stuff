defmodule DungeonCrawl.CLI.Main do
  @moduledoc """
  Entry point for the game and orchestrates cli logic
  triggered by "mix start"
  """
  alias Mix.Shell.IO, as: Shell
  # trigger
  def start_game do
    welcome_message()
    Shell.prompt("Press Enter to continue")

    #difficulty()
    # create a room and venture into it
    crawl(hero_choice(), DungeonCrawl.Room.all())
  end

  defp welcome_message do
    Shell.info("<<-==Dungeon Crawl v0.0.1 by @obsessedyouth -===>>")
    Shell.info("--------------------PLOT--------------------------")
    Shell.info("You awake in a dungeon full of monsters.")
    Shell.info("The dastardly evil king \"potion master\" is to blame")
    Shell.info("Some call him a programmer, a purveyor of arcane magic")
    Shell.info("You need to survive his creations and find the exit.")
  end

  defp hero_choice do
    hero = DungeonCrawl.CLI.HeroChoice.start()
    %{hero | name: "You"}
  end

  defp select_difficulty do
    # TODO: Add an extra option at the beginning of the game
    # to allow players to choose the difficulty level.

    # update the room map probability
    #easy = [0.3, 0.4, 0.3]
    #medium = [0.2, 0.3, 0.5]
    #hard = [0.01, 0.4, 0.59]
  end

  defp crawl(%{hit_points: 0}, _) do
    Shell.prompt("")
    Shell.cmd("cls")
    Shell.info("You have been gravely injured, it hurts..")
    Shell.info("As you walk slowly your vision blurs and you fall.")
    Shell.info("The potion master wins! You rest of this nightmare!")
    Shell.prompt("")
  end

  defp crawl(character, rooms) do
    Shell.info("You keep moving forward to the next room.")
    Shell.prompt("Press Enter to continue")
    Shell.cmd("cls")

    # pprint current status
    Shell.info(DungeonCrawl.Character.current_stats(character))
    # pick a random room
    pick = rooms
    |> Enum.map(fn room -> room.probability end)
    |> DungeonCrawl.CLI.Probability.bias_probability()

    {:ok, biased_room} = Enum.fetch(rooms, pick)

    biased_room
    |> DungeonCrawl.CLI.RoomActionsChoice.start()
    |> trigger_action(character)
    |> handle_action_result
  end

  defp trigger_action({room, action}, character) do
    Shell.cmd("cls")
    room.trigger.run(character, action)
  end

  defp handle_action_result({_, :exit}) do
    Shell.info("You found the exit! Yay! :) ")
    Shell.info("You may face the programmer send an email to hailelagi@gmail.com ")
    Shell.info("The potion master will code dungeons for free coffee :) ")
  end

  defp handle_action_result({character, _}), do: crawl(character, DungeonCrawl.Room.all())
end
