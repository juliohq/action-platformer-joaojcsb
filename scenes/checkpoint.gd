extends Node


## The parent node.
@export var parent: Node2D
## The first raycast for floor detection.
@export var raycast_a: RayCast2D
## The second raycast for floor detection.
@export var raycast_b: RayCast2D
## The X axis will be used.
@export var enable_x := true
## The X axis will be positive.
@export var positive_x := true
## The Y axis will be used.
@export var enable_y := false
## The Y axis will be positive.
@export var positive_y := false

## The valid position.
var position := Vector2()


func _physics_process(_delta: float) -> void:
	var on_floor := raycast_a.is_colliding() and raycast_b.is_colliding()
	
	if enable_x:
		if on_floor:
			store_x()
	
	if enable_y:
		if on_floor:
			store_y()


func store_x() -> void:
	if positive_x:
		position.x = maxf(parent.position.x, position.x)
	else:
		position.x = minf(parent.position.x, position.x)


func store_y() -> void:
	if positive_y:
		position.y = maxf(parent.position.y, position.y)
	else:
		position.y = minf(parent.position.y, position.y)


## Restores the player position stored in this checkpoint.
func restore() -> void:
	parent.position = position
