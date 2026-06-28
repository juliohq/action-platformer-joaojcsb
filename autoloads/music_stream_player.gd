extends Node


@export var stream: MusicStream
@export var autoplay := true
@export_range(0, 600, 0.01, "or_greater") var play_after := 0.0
@export var stop_on_exit := false
@export var boss := false


func _ready() -> void:
	if boss:
		Events.boss_defeated.connect(_boss_defeated)
	
	if autoplay:
		if play_after > 0.0:
			await get_tree().create_timer(play_after, false).timeout
		
		play()


func _exit_tree() -> void:
	if stop_on_exit:
		stop()


## Plays the music stream associated with this player.
func play() -> void:
	Music.play_music(stream)


## Stops the music stream.
func stop() -> void:
	Music.play_music(null)


func _boss_defeated() -> void:
	var tween := create_tween()
	tween.tween_property(Music, "volume_linear", 0.0, 3.0)
