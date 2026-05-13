extends Node


## The parent node.
@export var parent: Node2D
## The first raycast for floor detection.
@export var raycast_a: RayCast2D
## The second raycast for floor detection.
@export var raycast_b: RayCast2D

## The valid position.
var position := Vector2()


func _ready() -> void:
	position = parent.position


func _physics_process(_delta: float) -> void:
	var on_floor := raycast_a.is_colliding() and raycast_b.is_colliding()
	
	if on_floor:
		position = parent.position


## Restores the player position stored in this checkpoint.
func restore() -> void:
	parent.position = position
