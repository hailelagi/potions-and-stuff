defmodule TicTacToe do
  @moduledoc """
  Documentation for `TicTacToe`.
  """
  alias TicTacToe.Board, as: Board
  alias TicTacToe.Opponent, as: Opponent
  alias Mix.Shell.IO, as: Shell

  @doc """
  This defines the entry point of functions and data structures needed to play
  a game of tic-tac-toe in the terminal.
  ## Examples

      iex> TicTacToe.intro()
  """
  def intro do
    Shell.info("Hi, welcome to tic-tac-toe \n")
    Shell.info("The rules are simple! Select X or O when prompted \n")
    Shell.info("Enter a number one - nine(in words) corresponding to the positions displayed")
    Shell.info("Fill up the diagonal, horizontal or vertical to win!")
    IO.puts Board.example()
    if Shell.yes?("Would you like to play?") do
      Shell.cmd("clear")
      play(%Board{}, select())
    else
      exit_game()
    end
  end

  # Main game loop - orchestrates logic
  defp play(board, selected) do
    {mark, op_mark} = selected
    user_pos = choose(board)
    op_pos = Opponent.choose(board)

    board
    |> place_mark(user_pos, mark)
    |> place_mark(op_pos, op_mark)
    |> check_rules()
    |> play(selected)
  end


  # Gets user input and validates that to a choice of x or o
  def select do
    response = Shell.prompt("Would you like to be X or O?") |> String.trim |> String.capitalize()
    case response do
      "X" -> {:x, :o}
      "O" -> {:o, :x}
      _ -> Shell.info("Invalid input, try again. Enter X or O ")
              select()
    end
  end


  #Gets user input and validates a choice  on the board
  def choose(board) do
    valid_input = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
    choice = Shell.prompt("Please enter a position one - nine") |> String.trim |> String.downcase()
    valid = Enum.member?(valid_input, choice)

    if valid do
      position = String.to_atom("pos_#{choice}")
      {:ok, exist} = Map.fetch(board, position)

      case exist do
      # position is free
      " " -> position
      _ -> IO.puts("Sorry, that position is already taken!")
      choose(board)
      end
    else
      Shell.info("Invalid input please try again")
      choose(board)
    end
  end

  # Updates the game state
  defp place_mark(board, position, mark) do
    new_board = Board.update_position(mark, position, board)
    IO.puts(new_board)
    new_board
  end

  # Validates win, loss or draw according to tic-tac-toe rules
  def check_rules(board) do
    draw = board
    |> Map.values()
    |> Enum.filter(fn p -> p != " "  end)
    |> length

    # TODO: possible opportunity to refactor
    row_one = board.pos_one == board.pos_two and board.pos_one == board.pos_three and board.pos_one != " "
    row_two = board.pos_four == board.pos_five and board.pos_four == board.pos_six and board.pos_four != " "
    row_three = board.pos_seven == board.pos_eight and board.pos_seven == board.pos_nine and board.pos_seven != " "

    vert_one = board.pos_one == board.pos_four and board.pos_one == board.pos_seven and board.pos_one != " "
    vert_two = board.pos_two == board.pos_five and board.pos_two == board.pos_eight and board.pos_two != " "
    vert_three = board.pos_three == board.pos_six and board.pos_three == board.pos_nine and board.pos_three != " "

    diag_one = board.pos_one == board.pos_five and board.pos_one == board.pos_nine and board.pos_one != " "
    diag_two = board.pos_three == board.pos_five and board.pos_three == board.pos_seven and board.pos_three != " "


    cond do
      draw == 1 -> exit_game("It's a draw")
      row_one or vert_one -> exit_game("Player #{board.pos_one} won!")
      row_three or vert_three -> exit_game("Player #{board.pos_nine} won!")
      row_two or vert_two or diag_one or diag_two -> exit_game("Player #{board.pos_five} won!")
      true -> board
    end
  end

  # Terminates game gracefully
  def exit_game(outcome \\ "") do
    Shell.info(outcome)
    Shell.info("Thanks for checking out the game bye!")
    exit(":)")
  end
end
