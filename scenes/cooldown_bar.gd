extends ProgressBar


func _ready() -> void:
	hide()


func update(cooldown: float, max_cooldown: float) -> void:
	if cooldown >= max_cooldown:
		hide()
	else:
		show()
	
	max_value = max_cooldown
	value = cooldown
