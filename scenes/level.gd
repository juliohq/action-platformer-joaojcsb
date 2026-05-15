extends Node2D


@export_category("Nodes")
@export var world: Node2D
@export var background: TileMapLayer
@export var foreground: TileMapLayer


func _enter_tree() -> void:
	Globals.player_health = mini(Globals.player_health, Globals.PLAYER_HEALTH)
	Globals.max_player_health = Globals.PLAYER_HEALTH


func _ready() -> void:
	Events.bullet.connect(world.add_child)
	Events.hit_effect.connect(world.add_child)
	Events.orb_dropped.connect(world.add_child, CONNECT_DEFERRED)
	Events.loot_dropped.connect(world.add_child, CONNECT_DEFERRED)
	Events.player_hit.connect(world.add_child)
