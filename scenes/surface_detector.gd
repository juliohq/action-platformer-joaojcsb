extends Node2D


@export var left: RayCast2D
@export var right: RayCast2D
@export var ground_left: RayCast2D
@export var ground_right: RayCast2D


func is_colliding() -> bool:
	if left.is_colliding():
		return true
	
	if right.is_colliding():
		return true
	
	if ground_left.is_colliding():
		return true
	
	if ground_right.is_colliding():
		return true
	
	return false
