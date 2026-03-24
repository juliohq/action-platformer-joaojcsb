extends Node


## This node changes the velocity direction after a certain interval like roaming.

enum Callback {
	PROCESS,
	PHYSICS_PROCESS,
}

## During which callback will the velocity direction will change.
@export var callback := Callback.PROCESS
## What axes of the root node will be clamped.
@export_flags("X Axis", "Y Axis") var axes := 3
@export_range(0.01, 100.0, 0.01, "suffix:s") var interval := 1.0
## What velocity node will have its direction changed.
@export var velocity: Node

var time_left := interval


func _ready() -> void:
	set_process(callback == Callback.PROCESS)
	set_physics_process(callback == Callback.PHYSICS_PROCESS)


func _process(delta: float) -> void:
	roam(delta)


func _physics_process(delta: float) -> void:
	roam(delta)


func roam(delta: float) -> void:
	if time_left > 0.0:
		time_left -= delta
	else:
		# Reset time left
		time_left = interval
		
		# Apply direction change to velocity component
		var direction = Vector2.from_angle(TAU * randf())
		var final = Vector2()
		
		# X axis
		if axes & 0x1:
			final.x = direction.x
		
		# Y axis
		if axes & 0x2:
			final.y = direction.y
		
		velocity.direction = final.normalized()
