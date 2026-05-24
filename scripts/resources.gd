class_name Resources


static func save(resource: Resource, path: String) -> void:
	# Make sure folder exists
	Paths.ensure_dir_recursive(path)
	
	# Save resource to disk
	var err := ResourceSaver.save(resource, path)
	assert(err == OK, "%s \"%s\"" % [error_string(err), path])
	prints("Saved successfully:", path)
