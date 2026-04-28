extends BaseState


@export var idle: BaseState


func on_enter() -> void:
	root.direction = 0.0
	animator.play("HIT")
	await animator.animation_finished
	state_machine.current_state = idle
