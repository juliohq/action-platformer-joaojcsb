extends Node


## The parent node.
@export var parent: Node2D
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
	if enable_x:
		if positive_x:
			position.x = maxf(parent.position.x, position.x)
		else:
			position.x = minf(parent.position.x, position.x)
	
	if enable_y:
		if positive_y:
			position.y = maxf(parent.position.y, position.y)
		else:
			position.y = minf(parent.position.y, position.y)


## Restores the player position stored in this checkpoint.
func restore() -> void:
	parent.position = position
