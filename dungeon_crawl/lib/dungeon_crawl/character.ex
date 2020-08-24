defmodule DungeonCrawl.Character do
  @moduledoc """
  Abstract representation of a player in the game
  """
  defstruct name: nil,
            description: nil,
            hit_points: 0,
            max_hit_points: 0,
            attack_description: nil,
            damage_range: nil

  # static type checking
  @type t :: %DungeonCrawl.Character{
          name: String.t(),
          description: String.t(),
          hit_points: non_neg_integer(),
          max_hit_points: non_neg_integer(),
          attack_description: String.t(),
          damage_range: Range.t()
        }
  # string representation
  defimpl String.Chars do
    def to_string(character), do: character.name
  end
end
