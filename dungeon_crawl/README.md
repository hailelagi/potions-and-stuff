# DungeonCrawl

An exciting terminal game, survive a dungeon full of monsters and traps, earn treasure, exit safely!

## Installation
Assuming you have Elixir (1.9.2) installed. If not see the parent `README.md` for instructions.
`git clone` the parent repository, `cd` into `dungeon_crawl` and in your terminal enter `iex -S mix start`

## EXPERIMENTAL BRANCH 
Using conditional flow structures to catch errors from
impure functions

#TODO - will not be implemented on this branch

- <s> Implement difficulty level selection </s>

- <s> Dynamic room probability updates depending on user interaction </s>

- <s> Scoring System </s>

- <s> Item storage </s>

- <s> Extra options in the battle module - "run away" </s>

- <s> Expand Rooms and characters </s>

## Dependencies
```elixir
def deps do
  [
    {:dungeon_crawl, "~> 0.1.0"}
  ]
end
```
