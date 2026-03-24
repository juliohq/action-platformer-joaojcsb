extends CanvasModulate


## The current time of day represented as a decimal number.
@export_range(0.0, 1.0, 0.01) var time := 0.0: set = set_time
## The current day represented as an integer.
@export var day := 0
## How long a day will last (in seconds).
@export_range(1, 10_000, 1, "suffix:s") var day_duration := 60
## What colors will be used across the day.
@export var gradient: Gradient

@onready var speed: float = 1.0 / day_duration


func _process(delta: float) -> void:
	if time >= 1.0:
		time = 0.0
		day += 1
		Events.day_changed.emit(day)
	else:
		time += speed * delta
	
	color = gradient.sample(time)


func set_time(value: float) -> void:
	time = value
	Events.time_changed.emit(value)
