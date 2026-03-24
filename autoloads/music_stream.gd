extends Resource
class_name MusicStream


## The stream to be played.
@export var stream: AudioStream
## The volume of the stream to be played.
@export_range(0.01, 2.0, 0.01) var volume := 1.0
## The pitch scale of the stream to be played.
@export_range(0.01, 5.0, 0.01) var pitch_scale := 1.0
