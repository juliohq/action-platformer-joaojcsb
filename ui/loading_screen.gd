extends Control


@export_file("*.tscn") var scene_path := ""


func _ready() -> void:
	assert(ResourceLoader.exists(scene_path), "scene does not exist at %s" % scene_path)
	
	# Start loading in background
	var err = ResourceLoader.load_threaded_request(scene_path)
	assert(err == OK, "error %d" % err)


func _process(_delta: float) -> void:
	# Get loading status
	var _progress = []
	var status = ResourceLoader.load_threaded_get_status(scene_path, _progress)
	
	if _progress:
		%Progress.value = _progress[0]
	
	if status == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
		return
	
	# Change to the loaded scene
	assert(status == ResourceLoader.THREAD_LOAD_LOADED)
	get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(scene_path))
