@tool
extends TabContainer


enum AnimationType {
	TWO_DIRECTIONS,
	FOUR_DIRECTIONS,
	EIGHT_DIRECTIONS,
}

## The current animation library.
var animation_library: AnimationLibrary
## The current editor plugin.
var plugin: EditorPlugin


func setup(_plugin: EditorPlugin) -> void:
	plugin = _plugin
	update_animation()


func update_animation() -> void:
	animation_library = AnimationLibrary.new()
	
	# Create animations
	var animations := []
	
	match %AnimationType.selected:
		AnimationType.TWO_DIRECTIONS:
			animations = [
				"LEFT",
				"RIGHT",
			]
		AnimationType.FOUR_DIRECTIONS:
			animations = [
				"LEFT",
				"RIGHT",
				"UP",
				"DOWN",
			]
		AnimationType.EIGHT_DIRECTIONS:
			animations = [
				"LEFT",
				"LEFT_UP",
				"UP",
				"RIGHT_UP",
				"RIGHT",
				"RIGHT_DOWN",
				"DOWN",
				"LEFT_DOWN",
			]
	
	for animation_name: String in animations:
		var animation := Animation.new()
		
		# Create tracks
		var track := animation.add_track(Animation.TYPE_VALUE)
		animation.track_set_path(track, "Sprite:frame_coords")
		
		for i in %FrameCount.value:
			animation.track_insert_key(track, i + 1, Vector2i(i, 0))
		
		animation.length = %FrameCount.value
		var err := animation_library.add_animation(animation_name, animation)
		assert(err == OK, "failed to add animation")
	
	plugin.get_editor_interface().edit_resource(animation_library)


func _animation_type_changed(_index: int) -> void:
	update_animation()


func _frame_count_changed(_value: float) -> void:
	update_animation()
