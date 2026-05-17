extends CPUParticles2D


func _ready() -> void:
	one_shot = true
	emitting = true
	await finished
	queue_free()
