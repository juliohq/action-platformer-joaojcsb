extends MarginContainer


func _ready() -> void:
	Events.coins_changed.connect(update)
	
	update()


func update() -> void:
	%Count.text = str(Globals.coins)
