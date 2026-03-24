extends VBoxContainer


func _ready() -> void:
	Events.time_changed.connect(_time_changed)
	Events.day_changed.connect(_day_changed)


func _time_changed(time: float) -> void:
	%Time.value = time


func _day_changed(day: int) -> void:
	%Day.text = "Day: %d" % day
