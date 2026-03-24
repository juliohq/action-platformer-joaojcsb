extends Area2D


@export_range(1, 128, 1, "or_greater", "suffix:px/s") var speed := 128

var direction := Vector2()


func _physics_process(delta: float) -> void:
	translate(direction * speed * delta)


func _screen_exited() -> void:
	queue_free()
