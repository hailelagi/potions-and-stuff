defmodule DungeonCrawl.CLI.BaseCommands do
  @moduledoc """
  Reusable custom helper function module, abstracted
  repetitive functionality from rooms and hero_choice
  """
  @invalid_option {:error, "Invalid option"}
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

  def parse_answer(answer) do
    # take input from Shell.prompt// IO.get
    # parse it, and return the index value
    case Integer.parse(answer) do
      :error ->
        throw @invalid_option
      {option, _} -> option - 1
    end
  end

  def find_option_by_index(index, options) do
    Enum.at(options, index) || throw @invalid_option
  end

  def ask_for_option(options) do
    try do
      options
      |> display_options
      |> generate_question
      |> Shell.prompt
      |> parse_answer
      |> find_option_by_index(options)
      catch
      {:error, message} ->
        display_error(message)
        ask_for_option(options)
    end
  end

  def display_error(message) do
    Shell.cmd("cls")
    Shell.error(message)
    Shell.prompt("Please Enter to continue")
    Shell.cmd("cls")
  end
end
