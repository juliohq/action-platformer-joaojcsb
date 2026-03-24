extends Label


enum TimeFormat {
	FORMAT_HOURS   = 1 << 0,
	FORMAT_MINUTES = 1 << 1,
	FORMAT_SECONDS = 1 << 2,
	FORMAT_DEFAULT = FORMAT_HOURS | FORMAT_MINUTES | FORMAT_SECONDS
}


func _ready() -> void:
	update()


func tick() -> void:
	Globals.time_played += 1
	update()


func update() -> void:
	text = "Time Played: %s" % format_time(Globals.time_played)


func format_time(time: int, format := TimeFormat.FORMAT_DEFAULT, digit_format := "%02d") -> String:
	var digits = []
	
	if format & TimeFormat.FORMAT_HOURS:
		var hours = digit_format % [time / 3600]
		digits.append(hours)
		
	if format & TimeFormat.FORMAT_MINUTES:
		var minutes = digit_format % [time / 60]
		digits.append(minutes)
		
	if format & TimeFormat.FORMAT_SECONDS:
		var seconds = digit_format % [int(ceil(time)) % 60]
		digits.append(seconds)
		
	var formatted = ""
	var colon = ":"
	
	for digit in digits:
		formatted += digit + colon
		
	if formatted:
		formatted = formatted.rstrip(colon)
	
	return formatted
