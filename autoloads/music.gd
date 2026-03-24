extends AudioStreamPlayer


## Plays the given [code]music[/code] resource.
func play_music(music: MusicStream) -> void:
	if not music:
		return
	
	if not music.stream:
		return
	
	if stream == music.stream:
		return
	
	stream = music.stream
	volume_linear = music.volume
	pitch_scale = music.pitch_scale
	play()
