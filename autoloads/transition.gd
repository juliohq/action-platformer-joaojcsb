extends CanvasLayer


const DURATION := 0.5

## The current tween.
var tween: Tween


func start(scene_path: String) -> void:
	# Setup
	show()
	%Transition.modulate = Color.TRANSPARENT
	
	# Tween
	if tween:
		tween.kill()
	
	tween = create_tween()
	tween.tween_property(%Transition, "modulate", Color.WHITE, DURATION)
	tween.tween_callback(next_scene.bind(scene_path))
	tween.tween_property(%Transition, "modulate", Color.TRANSPARENT, DURATION)
	tween.tween_callback(hide)


func next_scene(scene_path: String) -> void:
	var scene: Node = load(scene_path).instantiate()
	var err := get_tree().change_scene_to_node(scene)
	assert(err == OK, "failed to change scene")
