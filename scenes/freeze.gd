extends Node


## How long the target will be freezed.
@export_range(0.1, 10.0, 0.1, "or_greater", "suffix:s") var time := 3.0
## The hit box area.
@export var hit_box: Area2D


func _ready() -> void:
	hit_box.hit.connect(_hit)


func _hit(body: Node2D) -> void:
	if "freeze_time" in body:
		body.freeze_time = time
	else:
		push_warning("%s does not have freeze time" % body.get_path())
