@tool
extends EditorScript


const LEVEL_PATH := "res://levels"


func _run() -> void:
	var level_scene: PackedScene = load("res://levels/level.tscn")

	# Generate 20 level scenes and save them
	for i in 20:
		var scene = create_inherited_scene(level_scene, "Level%d" % (i + 1))
		var scene_path = LEVEL_PATH.path_join("level_%d.tscn" % (i + 1))

		var err = ResourceSaver.save(scene, scene_path)

		if err == OK:
			print("Saved scene %s" % scene_path)
		else:
			push_error("Failed to save scene %s (error %d)" % [scene_path, err])
			return


func create_inherited_scene(inherits: PackedScene, root_name := "Scene") -> PackedScene:
	var scene := PackedScene.new()
	scene._bundled = { "names": [root_name], "variants": [inherits], "node_count": 1, "nodes": [-1, -1, 2147483647, 0, -1, 0, 0], "conn_count": 0, "conns": [], "node_paths": [], "editable_instances": [], "base_scene": 0, "version": 3 }
	return scene
