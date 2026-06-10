extends MarginContainer


func _ready() -> void:
	Events.power_changed.connect(update)
	Events.power_purchased.connect(update)
	Events.power_used.connect(_power_used)
	
	update()


func update() -> void:
	if Globals.power == Globals.Power.IMMUNITY:
		%Sign.text = "IM"
		%Count.text = str(Globals.power_immunity)
		%MaxCount.text = str(Globals.MAX_POWER_IMMUNITY)
	else:
		%Sign.text = "PZ"
		%Count.text = str(Globals.power_paralyze)
		%MaxCount.text = str(Globals.MAX_POWER_PARALYZE)


func _power_used() -> void:
	update()
	press()


func press() -> void:
	%Animator.play("PRESS")
	%Animator.seek(0.0)
