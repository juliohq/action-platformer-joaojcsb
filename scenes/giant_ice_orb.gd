extends "res://scenes/bullet.gd"


func _ready() -> void:
	super()
	animator.play("INTRO")
	animator.queue("LOOP")
