extends MarginContainer


const BLUE_ORB := preload("res://assets/ui/blue_orb/0.png")
const RED_ORB := preload("res://assets/ui/red_orb/0.png")


func _ready() -> void:
	Events.orb_changed.connect(update)
	
	update()


func update() -> void:
	%Orb.texture = [
		BLUE_ORB,
		RED_ORB,
	][Globals.orb]
