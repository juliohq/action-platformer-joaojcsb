@tool
extends Node


## This node clamps the given node to the given bounds.

enum Callback {
	PROCESS,
	PHYSICS_PROCESS,
}

## During which callback will the target node be clamped.
@export var callback := Callback.PROCESS
## What axes of the root node will be clamped.
@export_flags("X Axis", "Y Axis", "Z Axis") var axes := 7
## The node will be clamped to those bounds.
@export var bounds := AABB(Vector3(-8, -8, -8), Vector3(16, 16, 16))
## What root node will be clamped.
@export var root: Node3D


func _ready() -> void:
	if Engine.is_editor_hint():
		set_process(false)
		set_physics_process(false)
		
		if is_instance_valid(root):
			return
		
		await get_tree().process_frame
		
		if owner is Node3D:
			root = owner
	else:
		set_process(callback == Callback.PROCESS)
		set_physics_process(callback == Callback.PHYSICS_PROCESS)


func _process(_delta: float) -> void:
	clamp_to_bounds()


func _physics_process(_delta: float) -> void:
	clamp_to_bounds()


func clamp_to_bounds() -> void:
	# X axis
	if axes & 0x1:
		root.global_position.x = clampf(root.global_position.x, bounds.position.x, bounds.end.x)
	
	# Y axis
	if axes & 0x2:
		root.global_position.y = clampf(root.global_position.y, bounds.position.y, bounds.end.y)
	
	# Z axis
	if axes & 0x4:
		root.global_position.z = clampf(root.global_position.z, bounds.position.z, bounds.end.z)
