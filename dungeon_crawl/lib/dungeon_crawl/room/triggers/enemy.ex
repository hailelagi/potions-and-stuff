defmodule DungeonCrawl.Room.Triggers.Enemy do
  alias Mix.Shell.IO, as: Shell

  @behaviour DungeonCrawl.Room.Trigger
  @impl DungeonCrawl.Room.Trigger

  def run(character, %DungeonCrawl.Room.Action{id: :forward}) do
    enemy = Enum.random(DungeonCrawl.Enemies.all())

    Shell.info(enemy.description)
    Shell.info("The enemy #{enemy.name} looks at you suspiciously")
    Shell.info("You aren't taking chances, you attack first")
    {updated_char, _enemy} = DungeonCrawl.Battle.fight(character, enemy)

    {updated_char, :forward}
  end
end
