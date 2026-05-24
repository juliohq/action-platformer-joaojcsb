class_name Tweens


static func tween_empty(object: CanvasItem,
		ease_type: Tween.EaseType = Tween.EASE_IN_OUT,
		trans: Tween.TransitionType = Tween.TRANS_LINEAR) -> Tween:
	var tween := object.create_tween()
	tween.set_ease(ease_type)
	tween.set_trans(trans)
	return tween


static func tween_ex(object: CanvasItem, property: NodePath, final_val: Variant,
		duration: float, ease_type := Tween.EASE_IN_OUT,
		trans := Tween.TRANS_LINEAR) -> Tween:
	var tween := tween_empty(object, ease_type, trans)
	tween.tween_property(object, property, final_val, duration)
	return tween


static func tween_modulate_alpha(object: CanvasItem, alpha: float,
		duration: float, ease_type := Tween.EASE_IN_OUT,
		trans := Tween.TRANS_LINEAR) -> Tween:
	return tween_ex(object, "modulate:a", alpha, duration, ease_type, trans)


static func fade_in(object: CanvasItem, duration: float) -> Tween:
	return tween_modulate_alpha(object, 1.0, duration)


static func fade_out(object: CanvasItem, duration: float) -> Tween:
	return tween_modulate_alpha(object, 0.0, duration)


static func tween_modulate(object: CanvasItem, color: Color,
		duration: float, ease_type := Tween.EASE_IN_OUT,
		trans := Tween.TRANS_LINEAR) -> Tween:
	return tween_ex(object, "modulate", color, duration, ease_type, trans)


static func blink(object: CanvasItem, duration: float,
		ease_type := Tween.EASE_IN_OUT, trans := Tween.TRANS_LINEAR) -> Tween:
	assert(duration > 0.0, "duration cannot be zero")
	var tween := tween_empty(object, ease_type, trans)
	tween.set_loops()
	tween.tween_property(object, "modulate:a", 0.0, duration)
	tween.tween_property(object, "modulate:a", 1.0, duration)
	return tween


static func blink_ex(object: CanvasItem, duration: float, min_alpha: float,
		max_alpha: float, ease_type := Tween.EASE_IN_OUT,
		trans := Tween.TRANS_LINEAR) -> Tween:
	assert(duration > 0.0, "duration cannot be zero")
	var tween := tween_empty(object, ease_type, trans)
	tween.set_loops()
	tween.tween_property(object, "modulate:a", min_alpha, duration)
	tween.tween_property(object, "modulate:a", max_alpha, duration)
	return tween
