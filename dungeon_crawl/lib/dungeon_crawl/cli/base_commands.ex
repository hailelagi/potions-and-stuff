defmodule DungeonCrawl.CLI.BaseCommands do
  @moduledoc """
  Reusable custom helper function module, abstracted
  repetitive functionality from rooms and hero_choice
  """
  alias Mix.Shell.IO, as: Shell

  def ask_for_index(options) do
    answer =
    options
    |> display_options
    |> generate_question
    |> Shell.prompt
    |> Integer.parse()

    case answer do
      :error ->
        display_invalid_option()
        ask_for_index(options)

      {option, _} -> option - 1
    end
  end

  def ask_for_option(options) do
    index = ask_for_index(options)
    chosen_option = Enum.at(options, index)
    chosen_option || (display_invalid_option() && ask_for_option(options))
  end

  def display_options(options) do
    # pretty print list of values to shell
    options
    |> Enum.with_index(1)
    |> Enum.each(fn {option, index} ->
      Shell.info("#{index} - #{option}")
    end)

    options
  end

  def display_invalid_option do
    Shell.cmd("cls")
    Shell.error("Invalid option.")
    Shell.prompt("Press Enter to try again.")
    Shell.cmd("cls")
  end

  def generate_question(options) do
    # generate number of items and return a pprint list
    options = Enum.join(1..Enum.count(options), ",")
    "Which one? [#{options}]\n"
  end

  def parse_answer(answer) do
    # take input from Shell.prompt// IO.get
    # parse it, and return the index value
    {option, _} = Integer.parse(answer)
    option - 1
  end
end
