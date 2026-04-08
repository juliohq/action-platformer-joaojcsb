extends Node


## Emitted when the parent dies.
signal dead()

## The parent to die from fall.
@export var parent: Node2D
## The checkpoint.
@export var checkpoint: Node
## The threshold at which a death is considered.
@export var threshold := 320


func _ready() -> void:
	assert("position" in checkpoint, "checkpoint has no position field")


func _physics_process(_delta: float) -> void:
	if parent.position.y >= threshold:
		if _restore():
			# Reset gravity
			if "velocity" in parent:
				parent.velocity.y = 0.0
			
			# Restore parent position
			parent.position = checkpoint.position
		
		# Emit signal
		dead.emit()


func _restore() -> bool:
	return Globals.player_health > 1
