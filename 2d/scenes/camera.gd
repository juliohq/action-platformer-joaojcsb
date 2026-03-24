extends Camera2D


@export var reset_smoothing_on_ready := true


func _ready() -> void:
	if reset_smoothing_on_ready:
		# Reset smoothing is deferred so other actions performed on the frame
		# will take effect (e.g. change position of the player onready)
		reset_smoothing.call_deferred()
