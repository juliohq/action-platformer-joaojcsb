extends Node2D


## The size of the circle.
@export_range(1.0, 1024.0, 1.0, "suffix:px") var radius := 32.0
## The color the circle should be drawn with.
@export var radius_color := Color.WHITE
## The width of the circle.
@export var width := 1.0
## The color the circle should be filled with.
@export var inner_color := Color.TRANSPARENT
## The origin point of the circle.
@export var radius_origin := Vector2()
## The color of the circle shadow.
@export var shadow_color := Color.DARK_GRAY
## The offset of the circle shadow.
@export var shadow_offset := Vector2(0, 1)
## The thickness of the circle shadow.
@export var shadow_width := 1.0
@export_range(0.0, 10.0, 0.001, "suffix:px") var radius_scale := 0.25
@export_range(0.01, 1000.0, 0.01, "suffix:Hz") var animation_speed := 1.0

var _radius := 0.0
var counter := 0.0


func _draw() -> void:
	draw_arc(shadow_offset, _radius, 0.0, TAU, 32, shadow_color, shadow_width)
	draw_arc(radius_origin, _radius, 0.0, TAU, 32, radius_color, width)
	draw_circle(radius_origin, _radius, inner_color)


func reset() -> void:
	counter = 0.0


func _process(delta: float) -> void:
	_radius = ((sin(counter) * radius_scale) + 0.75) * radius
	counter += wrapf(animation_speed * delta, 0.0, TAU)
	queue_redraw()


func _on_visibility_changed() -> void:
	set_process(visible)


func get_save_state() -> Dictionary:
	return {
		"path": get_path(),
		"radius": _radius,
		"counter": counter,
	}
