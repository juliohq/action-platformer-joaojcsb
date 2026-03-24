extends Area2D


@export_flags("Areas", "Bodies") var types := 2
@export_file("*.tscn") var scene_path := ""

var _cached_scene: PackedScene


func _ready() -> void:
	assert(ResourceLoader.exists(scene_path), "scene path doesn't point to a valid scene")
	_cached_scene = load(scene_path)
	var callback = _teleport.unbind(1)
	
	if types & 0x1:
		area_entered.connect(callback, CONNECT_DEFERRED)
	
	if types & 0x2:
		body_entered.connect(callback, CONNECT_DEFERRED)


func _teleport() -> void:
	get_tree().change_scene_to_packed(_cached_scene)
