@tool
extends Node


## This node clamps the given node to the camera bounds.

enum Callback {
	PROCESS,
	PHYSICS_PROCESS,
}

## During which callback will the target node be clamped.
@export var callback := Callback.PROCESS
## What axes of the root node will be clamped.
@export_flags("X Axis", "Y Axis") var axes := 3
## How much spacing will be left from the camera bounds.
@export var margins := Vector2()
## What root node will be clamped.
@export var root: Node2D


func _ready() -> void:
	if Engine.is_editor_hint():
		set_process(false)
		set_physics_process(false)
		
		if is_instance_valid(root):
			return
		
		await get_tree().process_frame
		
		if owner is Node2D:
			root = owner
	else:
		set_process(callback == Callback.PROCESS)
		set_physics_process(callback == Callback.PHYSICS_PROCESS)


func _process(_delta: float) -> void:
	clamp_to_bounds()


func _physics_process(_delta: float) -> void:
	clamp_to_bounds()


func clamp_to_bounds() -> void:
	var camera: Camera2D = get_viewport().get_camera_2d()
	
	# X axis
	if axes & 0x1:
		root.global_position.x = clampf(root.global_position.x, camera.limit_left + margins.x, camera.limit_right - margins.x)
	
	# Y axis
	if axes & 0x2:
		root.global_position.y = clampf(root.global_position.y, camera.limit_top + margins.y, camera.limit_bottom - margins.y)
