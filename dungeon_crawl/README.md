# DungeonCrawl

An exciting terminal game, survive a dungeon full of monsters and traps, earn treasure, exit safely!

## Installation
Assuming you have Elixir (1.9.2) installed. If not see the parent `README.md` for instructions.
`git clone` the parent repository, `cd` into `dungeon_crawl` and in your terminal enter `mix do deps.get, deps.compile` to install dependencies and then `iex -S mix start` to play in interactive scripting mode.

## Experimental branches? What's up with that?

The various branches existed as ways to test out various implementations of error handling strategies in elixir.
¯\_(ツ)_/¯ should I delete them? idk probably, but they aren't hurting anyone, so I'll keep 'em here for reference.

## TODO: Features

- Implement difficulty level selection

- Dynamic room probability updates depending on user interaction

- Scoring System

- Item storage

- Extra options in the battle module - "run away"

- Expand Rooms and characters

## Dependencies
```elixir
  defp deps do
    [
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false},
      {:monadex, "~>1.1"}
    ]
  end
```
