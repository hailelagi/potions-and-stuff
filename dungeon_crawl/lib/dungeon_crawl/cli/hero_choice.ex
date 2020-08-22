defmodule DungeonCrawl.CLI.HeroChoice do
  @moduledoc """
  Hero logic controller, decides which hero to pick
  accesses the heroes macro(through the character struct)
  for a list of heroes, performs pretty prints and stores the user's
  choice borrows helpers from base to process input
  """
  alias Mix.Shell.IO, as: Shell
  import Dungeon.Crawl.CLI.BaseCommands

  def start do
    # linux and macOS ==> "clear"
    Shell.cmd("cls")
    Shell.info("Start by choosing your hero: ")

    # list of hero maps
    heroes = DungeonCrawl.Heroes.all()
    # partial application expecting incoming index
    find_hero_by_index = &Enum.at(heroes, &1)
    # returns a "hero" map

    # see base_commands for helpers
    heroes
    |> display_options
    |> generate_question
    |> Shell.prompt()
    |> parse_answer
    |> find_hero_by_index.()
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
