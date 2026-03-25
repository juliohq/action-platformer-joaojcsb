extends Node


## This node clamps the given node to the camera bounds.

enum Callback {
	PROCESS,
	PHYSICS_PROCESS,
}

## During which callback will the target node be clamped.
@export var callback := Callback.PROCESS
## Clamp on the X axis.
@export var clamp_x := true
## Clamp on the Y axis.
@export var clamp_y := true
## How much spacing will be left from the camera bounds.
@export var margins := Vector2()
## What root node will be clamped.
@export var root: Node2D


func _ready() -> void:
	set_process(callback == Callback.PROCESS)
	set_physics_process(callback == Callback.PHYSICS_PROCESS)


func _process(_delta: float) -> void:
	clamp_to_bounds()


func _physics_process(_delta: float) -> void:
	clamp_to_bounds()


func clamp_to_bounds() -> void:
	var camera: Camera2D = get_viewport().get_camera_2d()
	
	# X axis
	if clamp_x:
		root.global_position.x = clampf(root.global_position.x, camera.limit_left + margins.x, camera.limit_right - margins.x)
	
	# Y axis
	if clamp_y:
		root.global_position.y = clampf(root.global_position.y, camera.limit_top + margins.y, camera.limit_bottom - margins.y)
