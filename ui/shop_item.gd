extends PanelContainer


## Emitted when the shop item is purchased.
signal purchased(data: Dictionary)

## The item data.
var item := {}


func _ready() -> void:
	focus_entered.connect(_focus_entered)
	focus_exited.connect(_focus_exited)
	
	%Name.text = "%s ($ %3d)" % [item.name, item.cost]
	%Description.text = item.description


func _buy() -> void:
	purchased.emit(item)


func _gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		accept_event()
		_buy()


func _focus_entered() -> void:
	modulate = Color(1.5, 1.5, 1.5)


func _focus_exited() -> void:
	modulate = Color.WHITE
