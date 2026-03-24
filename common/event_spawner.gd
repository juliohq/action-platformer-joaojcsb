extends Node


## Emitted when the given node is spawned.
signal spawned(node: Node)

## The input action to trigger the spawn of the scene.
@export var action := &"ui_accept"
## The parent to add child scenes to.
@export var parent: Node
## The scene to be spawned.
@export var scene: PackedScene


func _input(event: InputEvent) -> void:
	if event.is_action_pressed(action):
		get_viewport().set_input_as_handled()
		spawn()


func spawn() -> void:
	var node = scene.instantiate()
	parent.add_child(node)
	spawned.emit(node)
