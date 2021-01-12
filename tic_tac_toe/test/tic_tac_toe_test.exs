defmodule TicTacToeTest do
  use ExUnit.Case
  alias TicTacToe.Board, as: Board
  alias TicTacToe.Opponent, as: Opponent
  doctest TicTacToe

  # wrote some tests should probably write more for coverage.
  test "Gets user input and validates it to an atom" do
    assert TicTacToe.select("X") == {:x, :o}
    assert TicTacToe.select("X") == {:x, :o}
    assert TicTacToe.select("O") == {:o, :x}
    assert TicTacToe.select("o") == {:o, :x}
  end

  test "Game exits" do
    assert catch_exit(TicTacToe.exit_game()) == ":)"
  end
end
