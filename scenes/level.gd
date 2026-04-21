extends Node2D


@export_category("Nodes")
@export var world: Node2D
@export var background: TileMapLayer
@export var foreground: TileMapLayer


func _enter_tree() -> void:
	Globals.reset()


func _ready() -> void:
	Events.bullet.connect(world.add_child)
	Events.orb_dropped.connect(world.add_child, CONNECT_DEFERRED)
	Events.loot_dropped.connect(world.add_child, CONNECT_DEFERRED)
