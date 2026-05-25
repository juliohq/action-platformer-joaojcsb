extends Node2D


@export var change_stage := false
@export var tutorial := Globals.Tutorial.BASIC
@export var change_health := false
@export_range(1, 10, 1, "or_greater", "suffix:HP") var health := 2
@export var change_orbs := false
@export_range(1, 10, 1, "or_greater") var orbs := 5
@export_category("Nodes")
@export var world: Node2D
@export var background: TileMapLayer
@export var foreground: TileMapLayer


func _enter_tree() -> void:
	# Update max health
	var max_health := Globals.PLAYER_HEALTH
	
	if change_health:
		max_health = health
	
	Globals.player_health = mini(Globals.player_health, max_health)
	Globals.max_player_health = max_health
	
	prints("[level] max health set to", max_health)
	
	# Update max orbs
	var max_red_orbs := Globals.RED_ORBS
	var max_blue_orbs := Globals.BLUE_ORBS
	
	if change_orbs:
		max_red_orbs = orbs
		max_blue_orbs = orbs
	
	Globals.red_orbs = mini(Globals.red_orbs, max_red_orbs)
	Globals.max_red_orbs = max_red_orbs
	
	Globals.blue_orbs = mini(Globals.blue_orbs, max_blue_orbs)
	Globals.max_blue_orbs = max_blue_orbs
	
	prints("[level] max orbs set to", max_red_orbs)
	
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
