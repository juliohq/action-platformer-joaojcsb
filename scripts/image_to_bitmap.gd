@tool
extends EditorScript


var images := []


func _run() -> void:
	for path: String in images:
		# Create bitmap resource
		var image := (load(path) as Texture2D).get_image()
		var bitmap := BitMap.new()
		bitmap.create_from_image_alpha(image)
		
		# Save bitmap resource
		var err := ResourceSaver.save(bitmap, path.replace(".png", ".tres"))
		
		if err != OK:
			print("Failed to save bitmap for %s (error %d)" % [path, err])
