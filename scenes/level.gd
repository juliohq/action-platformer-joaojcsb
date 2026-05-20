extends Node2D


@export var enable_health := true
@export var enable_coins := true
@export var enable_orbs := true
@export var enable_powers := true
@export_category("Nodes")
@export var world: Node2D
@export var background: TileMapLayer
@export var foreground: TileMapLayer


func _enter_tree() -> void:
	# Reset variables
	Globals.player_health = mini(Globals.player_health, Globals.PLAYER_HEALTH)
	Globals.max_player_health = Globals.PLAYER_HEALTH
	
	Globals.red_orbs = mini(Globals.red_orbs, Globals.RED_ORBS)
	Globals.max_red_orbs = Globals.RED_ORBS
	
	Globals.blue_orbs = mini(Globals.blue_orbs, Globals.BLUE_ORBS)
	Globals.max_blue_orbs = Globals.BLUE_ORBS
	
	# Tutorial variables
	Globals.enable_health = enable_health
	Globals.enable_coins = enable_coins
	Globals.enable_orbs = enable_orbs
	Globals.enable_powers = enable_powers


func _ready() -> void:
	Events.bullet.connect(world.add_child)
	Events.particles.connect(world.add_child)
	Events.hit_effect.connect(world.add_child, CONNECT_DEFERRED)
	Events.orb_dropped.connect(world.add_child, CONNECT_DEFERRED)
	Events.loot_dropped.connect(world.add_child, CONNECT_DEFERRED)
	Events.player_hit.connect(world.add_child)
