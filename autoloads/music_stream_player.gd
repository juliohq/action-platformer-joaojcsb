extends Node


@export var stream: MusicStream
@export var autoplay := true
@export_range(0, 600, 0.01, "or_greater") var play_after := 0.0


func _ready() -> void:
	if autoplay:
		if play_after > 0.0:
			await get_tree().create_timer(play_after, false).timeout
		
		play()


## Plays the music stream associated with this player.
func play() -> void:
	Music.play_music(stream)
