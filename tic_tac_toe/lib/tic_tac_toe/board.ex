defmodule TicTacToe.Board do
  alias TicTacToe.Board, as: Board
  @moduledoc"""
  Represents a board object state which is of the form

  pos_one | pos_two | pos_three
  ------------------------------
  pos_four | pos_five | pos_six
  -----------------------------
  pos_seven | pos_eight | pos_nine

  %Board{} and defines functions for it's interface
  """

  defstruct pos_one: " ",
            pos_two: " ",
            pos_three: " ",
            pos_four: " ",
            pos_five: " ",
            pos_six: " ",
            pos_seven: " ",
            pos_eight: " ",
            pos_nine: " "

  # pretty print string representation of a board
  defimpl String.Chars do
    def to_string(board) do
      separator = "-------------------"
    "\n   #{board.pos_one}   | #{board.pos_two}   | #{board.pos_three}
     \n #{separator}
     \n   #{board.pos_four}   | #{board.pos_five}   | #{board.pos_six}
     \n #{separator}
     \n   #{board.pos_seven}   | #{board.pos_eight}   |   #{board.pos_nine}
     "
    end
  end

    @doc """
  pretty print an example of the number - input mapping
  """
  def example do
    %Board{pos_one: "one", pos_two: "two",
    pos_three: "three   ", pos_four: "four", pos_five: "five",
    pos_six: "six   ", pos_seven: "seven", pos_eight: "eight", pos_nine: "nine" }
  end


  @doc """
  Takes in a mark - :atom
  position - string
  board  struct
  returns a new board state struct
  """
  def update_position(mark, position, board) do
    str_mark = mark |> to_string |> String.capitalize()
    Map.replace(board, position, str_mark)
  end
end
