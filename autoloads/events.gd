extends Node


## Emitted when the tutorial chest is opened.
signal chest_opened()
## Emitted when the skill level one is used.
signal skill_one_used()
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
## Emitted when the strong attack is used.
signal strong_attack_used()
## Emitted when the strong attack is ready to be used.
signal strong_attack_ready()
## Emitted when the strong attack cooldown changed.
signal strong_attack_cooldown(value, max_value)
## Emitted when the game is paused.
signal game_paused()
## Emitted when the game is resumed.
signal game_resumed()
## Emitted when the player health changes.
signal player_health_changed()
## Emitted when the player is hit.
signal player_hit(effect: Node2D)
## Sets the player invincible for some time.
signal player_invincible(time: float)
## Emitted when the player enters the shop.
signal shop_entered()
## Emitted when an item is purchased from shop.
signal shop_item_purchased()
## Emitted when the power tutorial is shown.
signal power_tutorial()
## Emitted when a power has been changed.
signal power_changed()
## Emitted when a power has been purchased from the shop.
signal power_purchased()
## Emitted when a power has been used.
signal power_used()
## Emitted when boss health has changed.
signal boss_health_changed(health: int, max_health: int)
## Emitted when the eagle spawner has started.
signal eagle_spawner_started()
## Emitted when the eagle spawner has stopped.
signal eagle_spawner_stopped()
## Emitted when an eagle is spawned.
signal eagle_spawned(eagle)
## Emitted when the boss is defeated.
signal boss_defeated()
## Emitted when the game over screen is shown.
signal game_over()
## Emitted when the game finished screen is shown.
signal game_finished()
