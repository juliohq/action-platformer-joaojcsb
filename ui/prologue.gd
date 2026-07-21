extends Control


const LEVEL := preload("res://levels/tutorial_a.tscn")

const TRANS_DURATION := 1.0
const TEXT_DURATION := 10.0


func _ready() -> void:
	# Setup
	%Text.modulate = Color.TRANSPARENT
	
	# Tween
	var tween := create_tween()
	tween.tween_property(%Text, "modulate:a", 1.0, TRANS_DURATION)
	tween.tween_property(%Text, "modulate:a", 0.0,
			TRANS_DURATION).set_delay(TEXT_DURATION)
	
	await tween.finished
	await get_tree().process_frame
	_finished()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_viewport().set_input_as_handled()
		_finished()
	elif event.is_action_pressed("ui_accept"):
		get_viewport().set_input_as_handled()
		_finished()
	elif event.is_action_pressed("attack_1"):
		get_viewport().set_input_as_handled()
		_finished()
	elif event.is_action_pressed("attack_2_hold"):
		get_viewport().set_input_as_handled()
		_finished()
	elif event.is_action_pressed("attack_2_press"):
		get_viewport().set_input_as_handled()
		_finished()


func _finished() -> void:
	get_tree().change_scene_to_packed(LEVEL)
