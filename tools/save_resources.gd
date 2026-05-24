@tool
extends EditorScript


var files: Array[String]


func _run() -> void:
	files = []
	
	add_files("res://")
	
	for file: String in files:
		var resource = load(file)
		Resources.save(resource, file)


func add_files(dir: String) -> void:
	# Skip "addons" folder
	if dir == "res://addons":
		return
	
	for file in DirAccess.get_files_at(dir):
		if file.get_extension() in ["tscn", "tres"]:
			files.append(dir.path_join(file))
	
	for subdir in DirAccess.get_directories_at(dir):
		add_files(dir.path_join(subdir))
