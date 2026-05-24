class_name Paths


static func to_file(path: String) -> String:
	return path.get_file().get_basename()


static func directories_from(path: String) -> PackedStringArray:
	var directories: PackedStringArray = []
	
	# Remove res:// part
	path = path.trim_prefix("res://")
	
	for part: String in path.split("/", false):
		if part.get_extension() == "":
			directories.append(part)
	
	return directories


static func ensure_dir_recursive(path: String) -> void:
	var absolute_path := "res://"
	
	for folder: String in directories_from(path):
		absolute_path = absolute_path.path_join(folder)
		
		if not DirAccess.dir_exists_absolute(absolute_path):
			var err := DirAccess.make_dir_recursive_absolute(absolute_path)
			assert(err == OK)
