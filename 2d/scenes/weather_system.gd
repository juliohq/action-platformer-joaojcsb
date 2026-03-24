extends Node


@export var playlist: Array[WeatherPattern]
## Whether the playlist will be shuffled on startup.
@export var shuffle_playlist := true

## The current.
var index := -1
## The current amount of rain.
var rain := 0.0
## The current amount of snow.
var snow := 0.0

@onready var rain_particles = $Layer/Rain


func _ready() -> void:
	Events.time_changed.connect(_time_changed)
	Events.day_changed.connect(_day_changed)
	
	if shuffle_playlist:
		playlist.shuffle()


func _time_changed(time: float) -> void:
	var pattern = playlist[index]
	
	rain = pattern.rain.sample_baked(time)
	rain_particles.amount_ratio = rain
	snow = pattern.snow.sample_baked(time)


func _day_changed(day: int) -> void:
	index = day % playlist.size()
