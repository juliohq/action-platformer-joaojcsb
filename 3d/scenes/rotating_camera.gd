extends Camera3D


## A rotating camera component. Mainly used for displaying 3D scenes.

## How far away the camera will be from the target.
@export_range(0.0, 1000.0, 0.1, "suffix:m") var radius := 1.0
## How far away in the Y axis the camera will be from the target.
@export_range(0.0, 100.0, 0.01, "suffix:m") var height := 1.0
## Where the target is positioned.
@export var target := Vector3()
## How fast the camera will rotate around the target.
@export_range(-1000.0, 1000.0, 0.01, "radians_as_degrees") var speed := 0.174533
## How much will be preprocessed before start rotating.
@export_range(-1000.0, 1000.0, 0.01, "suffix:s") var preprocess := 0.0

var counter := 0.0


func _ready() -> void:
	# Preprocess ahead of time
	_process(preprocess)


func _process(delta: float) -> void:
	var from = target + Vector3(cos(counter) * radius, height, sin(counter) * radius)
	look_at_from_position(from, target, Vector3.UP)
	counter = wrapf(counter + speed * delta, 0.0, TAU)
