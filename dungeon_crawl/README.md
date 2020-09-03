# DungeonCrawl

An exciting terminal game, survive a dungeon full of monsters and traps, earn treasure, exit safely!

## Installation
Assuming you have Elixir (1.9.2) installed. If not see the parent `README.md` for instructions.
`git clone` the parent repository, `cd` into `dungeon_crawl` and in your terminal enter `iex -S mix start`

## TODO: Features

- Implement difficulty level selection

- Dynamic room probability updates depending on user interaction

- Scoring System

- Item storage

- Extra options in the battle module - "run away"

- Expand Rooms and characters

## Dependencies
```elixir
def deps do
  [
    {:dungeon_crawl, "~> 0.1.0"}
  ]
end
```
