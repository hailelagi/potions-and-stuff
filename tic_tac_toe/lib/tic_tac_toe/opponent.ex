defmodule TicTacToe.Opponent do
  @moduledoc """
    Represents the simple 'ai' player you can play against
  """
  @doc """
    Simple automated opponent that chooses a random tile
    Takes in the board game state -%Board{},
    Outputs the board choice position as - String
  """
  def choose(board) do
    {position, value} = board |> Map.to_list() |> Enum.random()

    if value == " " do
      position
    else
      choose(board)
    end
  end
end
