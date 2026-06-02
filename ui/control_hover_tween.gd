extends Node


## The parent control to be animated.
@export var root: Control
## The ease type to be used.
@export var ease_type := Tween.EaseType.EASE_IN_OUT
## The transition type to be used.
@export var trans_type := Tween.TransitionType.TRANS_LINEAR
## How long the animation should last (in seconds).
@export_range(0.01, 10.0, 0.01, "or_greater", "suffix:s") var duration := 0.1
## The animation will take place from the control's center.
@export var from_center := true
## The amount of rotation.
@export_range(-180, 180, 0.001, "radians_as_degrees")
var rotation_amount := 0.08726
## The rotation will be negative randomly.
@export var bidirectional_rotation := true
## The amount of scale.
@export var scale_amount := Vector2(1.1, 1.1)

var tween: Tween


func _ready() -> void:
	root.mouse_entered.connect(_mouse_entered)
	root.mouse_exited.connect(_mouse_exited)
	
	if from_center:
		root.pivot_offset_ratio = Vector2.ONE * 0.5


func _mouse_entered() -> void:
	reset_tween()
	
	# Bidirectional rotation
	var final_rotation := rotation_amount
	
	if bidirectional_rotation:
		if randf() < 0.5:
			final_rotation = -rotation_amount
	
	tween.tween_property(root, "rotation", final_rotation, duration)
	tween.tween_property(root, "scale", scale_amount, duration)


func _mouse_exited() -> void:
	reset_tween()
	tween.tween_property(root, "rotation", 0.0, duration)
	tween.tween_property(root, "scale", Vector2.ONE, duration)


func reset_tween() -> void:
	if tween:
		tween.kill()
	
	tween = create_tween().set_parallel()
	tween.set_ease(ease_type)
	tween.set_trans(trans_type)
