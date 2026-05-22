extends Node2D


func _ready() -> void:
	Events.chest_opened.connect(show)
	
	hide()
