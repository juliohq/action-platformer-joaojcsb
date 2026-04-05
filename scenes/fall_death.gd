extends Node


## The parent to die from fall.
@export var parent: Node2D
## The checkpoint.
@export var checkpoint: Node
## The threshold at which a death is considered.
@export var threshold := 640


func _ready() -> void:
	assert("position" in checkpoint, "checkpoint has no position field")


func _physics_process(_delta: float) -> void:
	if parent.position.y >= threshold:
		# Reset gravity
		if "velocity" in parent:
			parent.velocity.y = 0.0
		
		# Restore parent position
		parent.position = checkpoint.position
