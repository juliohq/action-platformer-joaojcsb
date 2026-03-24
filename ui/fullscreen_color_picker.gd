extends Control


## The object holding the color property to be set.
var object: Object
## The property that should be set.
var property := &"color"


func _ready() -> void:
	assert(is_instance_valid(object))
	assert(&"color" in object)
	%ColorPicker.color = object.color


func _color_changed(color: Color) -> void:
	object[property] = %ColorPicker.color
