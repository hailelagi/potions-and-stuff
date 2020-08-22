defmodule Dungeon.Crawl.CLI.BaseCommands do
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

  def parse_answer(answer) do
    # take input from Shell.prompt// IO.get
    # parse it, and return the index value
    {option, _} = Integer.parse(answer)
    option - 1
  end
end
