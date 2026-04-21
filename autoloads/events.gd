extends Node


## Emitted when a bullet is shot.
signal bullet()
## Emitted when the loot is dropped.
signal loot_dropped(loot)
## Emitted when the player changes orb.
signal orb_changed()
## Emitted when an orb is dropped.
signal orb_dropped(orb)
## Emitted when the game is paused.
signal game_paused()
## Emitted when the game is resumed.
signal game_resumed()
## Emitted when the player health changes.
signal player_health_changed()
## Emitted when the game over screen is shown.
signal game_over()
## Emitted when the game finished screen is shown.
signal game_finished()
