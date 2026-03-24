extends Node


enum Callback {
	PROCESS,
	PHYSICS_PROCESS,
}

## The target node to be rotated.
@export var target: Node2D
## How fast the target node will be rotated.
@export_range(-999.0, 999.0, 0.01, "radians_as_degrees") var speed := TAU
## During which callback will the target node be rotated.
@export var callback := Callback.PROCESS


func _ready() -> void:
	set_process(callback == Callback.PROCESS)
	set_physics_process(callback == Callback.PHYSICS_PROCESS)


func _process(delta: float) -> void:
	target.rotate(speed * delta)


func _physics_process(delta: float) -> void:
	target.rotate(speed * delta)
