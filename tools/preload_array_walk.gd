@tool
extends EditorScript


const PATH := "res://tools"


func _run() -> void:
	# Walk
	var files := walk(PATH)
	
	# Print
	print("var foo := [")
	
	for path: String in files:
		print("\tpreload(\"%s\")," % path)
	
	print("]")


func walk(folder: String) -> PackedStringArray:
	var files := []
	
	# Recursive search
	for subfolder: String in DirAccess.get_directories_at(folder):
		var path := folder.path_join(subfolder)
		var subfiles := walk(path)
		
		for file: String in subfiles:
			if accept(file):
				files.append(file)
	
	for file: String in DirAccess.get_files_at(folder):
		var path := folder.path_join(file)
		
		if accept(path):
			files.append(path)
	
	return files


func accept(file: String) -> bool:
	# Ensure resources only
	if not ResourceLoader.exists(file):
		return false
	
	# Try to load resource
	var resource = load(file)
	
	return _accept(resource)


func _accept(resource: Resource) -> bool:
	return resource is GDScript
