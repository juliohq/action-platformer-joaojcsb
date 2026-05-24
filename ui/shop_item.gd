extends PanelContainer


## Emitted when the shop item is purchased.
signal purchased(data: Dictionary)

## The item data.
var item := {}


func _ready() -> void:
	%Buy.pressed.connect(_buy)
	
	%Name.text = item.name
	%Description.text = item.description
	%Buy.text = "Comprar ($ %3d)" % item.cost


func _buy() -> void:
	purchased.emit(item)
