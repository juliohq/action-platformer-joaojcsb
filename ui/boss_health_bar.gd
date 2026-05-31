extends TextureProgressBar


const DURATION := 0.1

var tween: Tween


func _ready() -> void:
	Events.boss_health_changed.connect(update)
	Events.boss_defeated.connect(_boss_defeated)


func update(health: int, max_health: int) -> void:
	if health < value:
		blink()
	
	show()
	max_value = max_health
	value = health


func blink() -> void:
	if tween:
		tween.kill()
	
	modulate.a = 0.0
	tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, DURATION)


func _boss_defeated() -> void:
	hide()
