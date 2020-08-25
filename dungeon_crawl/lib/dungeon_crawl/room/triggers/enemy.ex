defmodule DungeonCrawl.Room.Triggers.Enemy do
  @behaviour DungeonCrawl.Room.Trigger

  alias Mix.Shell.IO, as: Shell

  def run(character, %DungeonCrawl.Room.Action{id: :forward}) do
    enemy = Enum.random(Dungeon.Crawl.Enemies.all)

    Shell.info(enemy.description)
    Shell.info("The enemy #{enemy.name} looks at you suspiciously")
    Shell.info("You aren't taking chances, you attack first")
    {updated_char, _enemy} = DungeonCrawl.Battle.fight(character, enemy)

    {updated_char, :forward}
  end
end