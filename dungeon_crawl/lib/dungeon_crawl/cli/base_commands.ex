defmodule DungeonCrawl.CLI.BaseCommands do
  @moduledoc """
  Reusable custom helper function module, abstracted
  repetitive functionality from rooms and hero_choice
  """
  alias Mix.Shell.IO, as: Shell

  def display_options(options) do
    # pretty print list of values to shell
    options
    |> Enum.with_index(1)
    |> Enum.each(fn {option, index} ->
      Shell.info("#{index} - #{option}")
    end)

    options
  end

  def generate_question(options) do
    # generate number of items and return a pprint list
    options = Enum.join(1..Enum.count(options), ",")
    "Which one? [#{options}]\n"
  end

  def parse_answer!(answer) do
    # take input from Shell.prompt// IO.get
    # parse it, and return the index value
    case Integer.parse(answer) do
      :error ->
        raise DungeonCrawl.CLI.InvalidOptionError
      {option, _} -> option - 1
    end
  end

  def find_option_by_index!(index, options) do
    Enum.at(options, index)
    || raise DungeonCrawl.CLI.InvalidOptionError
  end

  def ask_for_option(options) do
    try do
      options
      |> display_options
      |> generate_question
      |> Shell.prompt
      |> parse_answer!
      |> find_option_by_index!(options)
      rescue
      err in DungeonCrawl.CLI.InvalidOptionError ->
        display_error(err)
        ask_for_option(options)
    end
  end

  def display_error(err) do
    Shell.cmd("cls")
    Shell.error(err.message)
    Shell.prompt("Press Enter to continue")
    Shell.cmd("cls")
  end
end
