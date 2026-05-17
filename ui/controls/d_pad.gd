extends Sprite2D


enum Mode {
	HORIZONTAL,
	VERTICAL,
	DUAL,
}

@export var mode := Mode.HORIZONTAL


func _ready() -> void:
	match mode:
		Mode.HORIZONTAL:
			%Animator.play("HORIZONTAL")
		Mode.VERTICAL:
			%Animator.play("HORIZONTAL")
		Mode.DUAL:
			%Animator.play("DUAL")
