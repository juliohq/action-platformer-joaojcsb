extends Node


## The camera to be shook.
@export var camera: Camera2D
## How many pixels the shake will be at maximum.
@export_range(0.01, 8.0, 0.01, "or_greater", "suffix:px")
var default_amount := 4.0
## How long the shake will take.
@export_range(0.01, 8.0, 0.01, "or_greater", "suffix:s")
var default_duration := 0.2
## How the amount will be distributed over the shake span.
@export_exp_easing("attenuation") var falloff := 1.0

## The current shake amount.
var current_amount := 0.0
## The time left to shake.
var time_left := 0.0
## The current shake wait time.
var wait_time := 0.0


## Start a camera shake with [code]amount[/code] and [code]duration[/code].
func shake(amount := default_amount, duration := default_duration) -> void:
	current_amount = amount
	time_left = duration
	wait_time = duration


func _process(delta: float) -> void:
	if time_left > 0.0:
		time_left -= delta
		current_amount = lerpf(current_amount, 0.0, 1.0 - time_left / wait_time)
		camera.offset = Vector2.from_angle(TAU * randf()) * current_amount
		
		if time_left <= 0.0:
			current_amount = 0.0
			time_left = 0.0
			wait_time = 0.0
			camera.offset = Vector2()
