class_name NodeManager


## Calls [code]free[/code] on all children of [code]parent[/code].
static func children_free(parent: Node) -> void:
	for child: Node in parent.get_children():
		child.free()


## Calls [code]queue_free[/code] on all children of [code]parent[/code].
static func children_queue_free(parent: Node) -> void:
	for child: Node in parent.get_children():
		child.queue_free()


## Returns the count of direct and indirect nodes of [code]parent[/code].
static func descendant_count(parent: Node) -> int:
	return parent.find_children("*", "", true, false).size()


## Spawns the array of nodes in polar coordinates.
static func polar_spawn(parent: Node, nodes: Array, origin: Vector2,
		radius: float) -> void:
	var count := nodes.size()
	var size := TAU / count
	var angle := 0.0
	
	for node: Node2D in nodes:
		node.position = origin + Vector2.from_angle(angle) * radius
		parent.add_child(node)
		angle += size


## Copy Sprite2D properties between from and to.
static func copy_sprite(from: Sprite2D, to: Sprite2D) -> void:
	to.texture = from.texture
	to.transform = from.transform
	to.offset = from.offset
	to.hframes = from.hframes
	to.vframes = from.vframes
	to.texture_filter = from.texture_filter


## Copy AnimationPlayer properties between from and to.
static func copy_animator(from: AnimationPlayer, to: AnimationPlayer) -> void:
	# Copy properties
	to.playback_auto_capture = from.playback_auto_capture
	to.playback_auto_capture_duration = from.playback_auto_capture_duration
	to.playback_auto_capture_transition_type = from.playback_auto_capture_transition_type
	to.playback_auto_capture_ease_type = from.playback_auto_capture_ease_type
	to.playback_default_blend_time = from.playback_default_blend_time
	
	to.speed_scale = from.speed_scale
	to.movie_quit_on_finish = from.movie_quit_on_finish
	
	to.active = from.active
	to.deterministic = from.deterministic
	to.reset_on_save = from.reset_on_save
	to.root_node = from.root_node
	to.callback_mode_process = from.callback_mode_process
	to.callback_mode_method = from.callback_mode_method
	to.callback_mode_discrete = from.callback_mode_discrete
	
	# Copy animation libraries
	for library: String in from.get_animation_library_list():
		var err := to.add_animation_library(library,
				from.get_animation_library(library))
		assert(err == OK, "failed to copy animation library %s" % library)
	
	# Copy current animation
	to.current_animation = from.current_animation
	to.seek(from.current_animation_position, true, true)
