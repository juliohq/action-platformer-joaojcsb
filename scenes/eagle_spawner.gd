extends Node


@export_range(0.01, 10.0, 0.01, "or_greater", "suffix:s")
var idle_time := 5.0
@export var top_left: Marker2D
@export var bottom_left: Marker2D
@export var top_right: Marker2D
@export var bottom_right: Marker2D

var time_left := 0.0
## The direction the will be spawned.
var direction := &"left"


func _ready() -> void:
	Events.eagle_spawner_started.connect(_started)
	Events.eagle_spawner_stopped.connect(_stopped)
	
	set_process(false)


func _started() -> void:
	set_process(true)


func _stopped() -> void:
	set_process(false)


func _process(delta: float) -> void:
	var eagle_count := get_tree().get_nodes_in_group("eagles").size()
	
	if eagle_count <= 0:
		if time_left > 0.0:
			time_left -= delta
		else:
			time_left += idle_time
			spawn()


func spawn() -> void:
	if direction == &"left":
		spawn_eagle(top_left, 1)
		spawn_eagle(bottom_left, 1)
		direction = &"right"
	else:
		spawn_eagle(top_right, -1)
		spawn_eagle(bottom_right, -1)
		direction = &"left"


func spawn_eagle(at: Marker2D, towards: float) -> void:
	var eagle := preload("res://enemies/eagle/eagle.tscn").instantiate()
	eagle.direction = towards
	eagle.global_position = at.global_position
	Events.eagle_spawned.emit(eagle)
