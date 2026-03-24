extends Node


enum Callback {
	PROCESS,
	PHYSICS_PROCESS,
}

## The target node to be rotated.
@export var target: Node3D
## How fast the target node will be rotated.
@export_range(-999.0, 999.0, 0.01, "radians_as_degrees") var speed := TAU
## The axis to be rotated.
@export var axes := Vector3.ONE
## Rotate in local coordinates or global coordinates.
@export var local := true
## During which callback will the target node be rotated.
@export var callback := Callback.PROCESS


func _ready() -> void:
	set_process(callback == Callback.PROCESS)
	set_physics_process(callback == Callback.PHYSICS_PROCESS)


func _process(delta: float) -> void:
	if local:
		target.rotate(axes, speed * delta)
	else:
		target.global_rotate(axes, speed * delta)


func _physics_process(delta: float) -> void:
	if local:
		target.rotate(axes, speed * delta)
	else:
		target.global_rotate(axes, speed * delta)
