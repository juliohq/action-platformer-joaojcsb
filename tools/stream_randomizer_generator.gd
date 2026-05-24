@tool
extends EditorScript


const STREAMS := []


func _run() -> void:
	var randomizer = AudioStreamRandomizer.new()
	
	for stream: AudioStream in STREAMS:
		randomizer.add_stream(randomizer.streams_count, stream)
	
	# Save to disk
	Resources.save(randomizer, "res://randomizer.tres")
