extends Node


## Emitted when the tutorial chest is opened.
signal chest_opened()
## Emitted when a bullet is shot.
signal bullet(node: Node2D)
## Emitted when particles are spawned.
signal particles(particles: Node2D)
## Emitted when a bullet hits.
signal hit_effect(effect: Node2D)
## Emitted when the loot is dropped.
signal loot_dropped(loot)
## Emitted when the coins are changed.
signal coins_changed()
## Emitted when the player changes orb.
signal orb_changed()
## Emitted when the player earns an orb.
signal orb_added()
## Emitted when an orb is dropped.
signal orb_dropped(orb)
## Emitted when orbs were consumed.
signal orb_consumed()
## Emitted when the strong power is used.
signal strong_power_used()
## Emitted when the strong power is ready to be used.
signal strong_power_ready()
## Emitted when the strong power cooldown changed.
signal strong_power_cooldown(value, max_value)
## Emitted when the game is paused.
signal game_paused()
## Emitted when the game is resumed.
signal game_resumed()
## Emitted when the player health changes.
signal player_health_changed()
## Emitted when the player is hit.
signal player_hit(effect: Node2D)
## Emitted when the game over screen is shown.
signal game_over()
## Emitted when the game finished screen is shown.
signal game_finished()
