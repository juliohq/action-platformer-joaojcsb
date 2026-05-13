extends ProgressBar


@export var autohide := true


func _ready() -> void:
	if autohide:
		hide()


func update(cooldown: float, max_cooldown: float) -> void:
	if autohide:
		if cooldown >= max_cooldown:
			hide()
		else:
			show()
	
	max_value = max_cooldown
	value = cooldown
