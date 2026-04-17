@tool
extends EditorScript


func _run() -> void:
	var randomizer = AudioStreamRandomizer.new()
	
	for stream in []:
		randomizer.add_stream(randomizer.streams_count, stream)
	
	ResourceSaver.save(randomizer, "randomizer.tres")
