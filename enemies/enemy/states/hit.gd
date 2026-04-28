extends BaseState


@export var idle: BaseState


func on_enter() -> void:
	animator.play("HIT")
	await animator.animation_finished
	state_machine.current_state = idle


func on_physics_process(_delta: float) -> void:
	root.direction = 0.0
