extends Node2D


@export var change_stage := false
@export var tutorial := Globals.Tutorial.BASIC
@export_range(1, 10, 1, "or_greater") var orbs := 5
@export_category("Nodes")
@export var world: Node2D
@export var background: TileMapLayer
@export var foreground: TileMapLayer


func _enter_tree() -> void:
	# Reset variables
	Globals.player_health = mini(Globals.player_health, Globals.PLAYER_HEALTH)
	Globals.max_player_health = Globals.PLAYER_HEALTH
	
	Globals.red_orbs = mini(Globals.red_orbs, orbs)
	Globals.max_red_orbs = orbs
	
	Globals.blue_orbs = mini(Globals.blue_orbs, orbs)
	Globals.max_blue_orbs = orbs
	
	# Tutorial stage
	if change_stage:
		Globals.tutorial = tutorial


func _ready() -> void:
	Events.bullet.connect(world.add_child)
	Events.particles.connect(world.add_child)
	Events.hit_effect.connect(world.add_child, CONNECT_DEFERRED)
	Events.orb_dropped.connect(world.add_child, CONNECT_DEFERRED)
	Events.loot_dropped.connect(world.add_child, CONNECT_DEFERRED)
	Events.player_hit.connect(world.add_child)
