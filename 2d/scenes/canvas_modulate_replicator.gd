extends CanvasModulate


@export var target: CanvasModulate


func _process(_delta: float) -> void:
	color = target.color
