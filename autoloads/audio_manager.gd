extends Node


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS


func play(stream: AudioStream, volume := 1.0, bus := &"Master", max_polyphony := 8) -> void:
	var sound_count := 0
	
	for child: AudioStreamPlayer in get_children():
		if child.stream == stream:
			sound_count += 1
		
		if sound_count >= max_polyphony:
			return
	
	var sound := preload("res://autoloads/sound.tscn").instantiate()
	sound.stream = stream
	sound.volume_linear = volume
	sound.bus = bus
	add_child(sound)
