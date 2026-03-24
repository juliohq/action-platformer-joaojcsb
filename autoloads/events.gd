extends Node


## Emitted when the time of day has changed.
signal time_changed(time: float)
## Emitted when the day has changed.
signal day_changed(day: int)
## Emitted when the game is paused.
signal game_paused()
## Emitted when the game is resumed.
signal game_resumed()
## Emitted when the UI should be updated. <br>
## This is useful to update info related to the player.
signal ui_updated()
## Emitted when the game over screen is shown.
signal game_over()
## Emitted when the game finished screen is shown.
signal game_finished()
