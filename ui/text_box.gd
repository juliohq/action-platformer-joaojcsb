extends VBoxContainer


func _ready() -> void:
	on_top()


func show_text(text: String) -> void:
	%Text.text = text


func on_top() -> void:
	_hide_spacers()
	%BottomSpacer.show()


func on_bottom() -> void:
	_hide_spacers()
	%TopSpacer.show()


func _hide_spacers() -> void:
	%TopSpacer.hide()
	%BottomSpacer.hide()
