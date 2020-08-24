defmodule DungeonCrawl.Room.Action do
  @moduledoc """
  data structure to represent actions in the game
  """
  alias DungeonCrawl.Room.Action, as: Action
  defstruct id: nil, label: nil
  # static type checking
  @type t :: %Action{id: atom, label: String.t()}

  def forward, do: %Action{id: :forward, label: "Move forward."}
  def rest, do: %Action{id: :rest, label: "Take a better look and rest."}
  def search, do: %Action{id: :search, label: "Search the room."}

  # string representation
  defimpl String.Chars do
    def to_string(action), do: action.label
  end
end
