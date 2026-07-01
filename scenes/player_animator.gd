extends AnimationPlayer


const RED_ORB := {
	preload("res://assets/sprites/player/attack.png"):
		preload("res://assets/sprites/player/red_orb/attack.png"),
	preload("res://assets/sprites/player/death.png"):
		preload("res://assets/sprites/player/red_orb/death.png"),
	preload("res://assets/sprites/player/fall.png"):
		preload("res://assets/sprites/player/red_orb/fall.png"),
	preload("res://assets/sprites/player/hit.png"):
		preload("res://assets/sprites/player/red_orb/hit.png"),
	preload("res://assets/sprites/player/idle.png"):
		preload("res://assets/sprites/player/red_orb/idle.png"),
	preload("res://assets/sprites/player/jump.png"):
		preload("res://assets/sprites/player/red_orb/jump.png"),
	preload("res://assets/sprites/player/player_hit.png"):
		preload("res://assets/sprites/player/red_orb/player_hit.png"),
	preload("res://assets/sprites/player/ranged.png"):
		preload("res://assets/sprites/player/red_orb/ranged.png"),
	preload("res://assets/sprites/player/run.png"):
		preload("res://assets/sprites/player/red_orb/run.png"),
}
const BLUE_ORB := {
	preload("res://assets/sprites/player/attack.png"):
		preload("res://assets/sprites/player/blue_orb/attack.png"),
	preload("res://assets/sprites/player/death.png"):
		preload("res://assets/sprites/player/blue_orb/death.png"),
	preload("res://assets/sprites/player/fall.png"):
		preload("res://assets/sprites/player/blue_orb/fall.png"),
	preload("res://assets/sprites/player/hit.png"):
		preload("res://assets/sprites/player/blue_orb/hit.png"),
	preload("res://assets/sprites/player/idle.png"):
		preload("res://assets/sprites/player/blue_orb/idle.png"),
	preload("res://assets/sprites/player/jump.png"):
		preload("res://assets/sprites/player/blue_orb/jump.png"),
	preload("res://assets/sprites/player/player_hit.png"):
		preload("res://assets/sprites/player/blue_orb/player_hit.png"),
	preload("res://assets/sprites/player/ranged.png"):
		preload("res://assets/sprites/player/blue_orb/ranged.png"),
	preload("res://assets/sprites/player/run.png"):
		preload("res://assets/sprites/player/blue_orb/run.png"),
}

@export var sprite: Sprite2D


func _post_process_key_value(_animation: Animation, _track: int, value: Variant,
		object_id: int, _object_sub_idx: int) -> Variant:
	if Globals.tutorial <= Globals.Tutorial.CHANGE_ORB:
		return value
	
	if object_id == sprite.get_instance_id():
		if value is Texture2D:
			if Globals.orb == Globals.Orb.RED:
				return RED_ORB[value]
			return BLUE_ORB[value]
	
	return value
