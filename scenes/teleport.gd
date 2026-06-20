extends Area2D


@export_flags("Areas", "Bodies") var types := 2
@export_file("*.tscn") var scene_path := ""
@export var audio: AudioStream
@export_range(-1, 1, 1, "or_greater", "or_less", "suffix:px")
var offset := 0.0
@export_range(0.01, 1.0, 0.01, "or_greater", "suffix:s")
var out_duration := 0.5
@export_range(0.01, 1.0, 0.01, "or_greater", "suffix:s")
var in_duration := 0.5

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
	AudioManager.play(audio, 1.0, &"Sounds")
	Globals.teleport_offset = offset
	Transition.start(scene_path, out_duration, in_duration)
