@tool
extends EditorScript


func read_words(path: String) -> PackedStringArray:
	var words = []
	
	if FileAccess.file_exists(path):
		var f = FileAccess.open(path, FileAccess.READ)
		var err = f.get_error()
		
		if err == OK:
			while not f.eof_reached():
				var line = f.get_line()
				
				if line:
					words.append(line)
		else:
			push_error("Error when reading file %s (%d)" % [path, err])
	
	return words


func _run() -> void:
	var words = read_words("res://common/word_list/words.txt")
	var f = FileAccess.open("res://common/word_list/short_words.txt", FileAccess.WRITE)
	
	for word in words:
		var length = word.length()
		
		if length >= 3 and length <= 4:
			f.store_line(word)
