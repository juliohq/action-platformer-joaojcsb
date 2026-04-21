extends MarginContainer


const DELAY := 1.0
const DURATION := 20.0


func _ready() -> void:
	# Setup
	show()
	modulate = Color.TRANSPARENT
	
	# Animate
	var tween := create_tween()
	tween.tween_property(self, "modulate:a", 1.0, DELAY)
	tween.tween_property(self, "modulate:a", 0.0, DELAY).set_delay(DURATION)
	tween.parallel().tween_method(update_time, DURATION, 0.0, DURATION)
	
	update_time(DURATION)


func update_time(value: float) -> void:
	%TimeLeft.max_value = DURATION
	%TimeLeft.value = value
