extends Area2D


## Emitted when this hint is used.
signal used()

@export var pivot: Node2D

## The current tween.
var tween: Tween


func _ready() -> void:
	body_entered.connect(update.unbind(1))
	body_exited.connect(update.unbind(1))
	
	set_process_unhandled_input(false)
	pivot.hide()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(&"confirm"):
		get_viewport().set_input_as_handled()
		
		if has_overlapping_bodies():
			used.emit()


func update() -> void:
	if has_overlapping_bodies():
		set_process_unhandled_input(true)
		pivot.show()
	else:
		set_process_unhandled_input(false)
		pivot.hide()
