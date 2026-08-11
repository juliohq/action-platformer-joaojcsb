extends Camera2D


@export var reset_smoothing_on_ready := true
@export var bounds: StaticBody2D


func _ready() -> void:
	if reset_smoothing_on_ready:
		# Reset smoothing is deferred so other actions performed on the frame
		# will take effect (e.g. change position of the player onready)
		reset_smoothing.call_deferred()


func _physics_process(_delta: float) -> void:
	bounds.position = get_screen_center_position()
