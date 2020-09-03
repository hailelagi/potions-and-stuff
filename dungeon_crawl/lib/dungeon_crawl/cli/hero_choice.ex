defmodule DungeonCrawl.CLI.HeroChoice do
  @moduledoc """
  Hero logic controller, decides which hero to pick
  accesses the heroes macro(through the character struct)
  for a list of heroes, performs pretty prints and stores the user's
  choice borrows helpers from base to process input
  """
  alias Mix.Shell.IO, as: Shell
  import DungeonCrawl.CLI.BaseCommands

  def start do
    # linux and macOS ==> "clear"
    Shell.cmd("cls")
    Shell.info("Start by choosing your hero: ")

    # list of hero maps
    DungeonCrawl.Heroes.all()
    |> ask_for_option
    |> confirm_hero
  end

  defp confirm_hero(chosen_hero) do
    # linux and macOS "clear"
    Shell.cmd("cls")
    Shell.info("is this a wise choice? The dungeon is tricky?")
    Shell.info(chosen_hero.description)
    if Shell.yes?("Confirm"), do: chosen_hero, else: start()
  end
end
