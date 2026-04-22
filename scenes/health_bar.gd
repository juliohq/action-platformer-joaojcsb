extends ProgressBar


func _ready() -> void:
	hide()


func update(health: int, max_health: int) -> void:
	max_value = max_health
	value = health
