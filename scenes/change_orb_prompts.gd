extends Node2D


func _ready() -> void:
	Events.skill_one_used.connect(_skill_one_used, CONNECT_ONE_SHOT)
	
	hide()


func _skill_one_used() -> void:
	show()
