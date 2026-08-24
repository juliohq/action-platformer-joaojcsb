class_name Tweens


static func reset_tween(tween: Tween, object: Node,
		ease_type := Tween.EASE_IN_OUT, trans_type := Tween.TRANS_LINEAR,
		speed_scale := 1.0,
		callback := Tween.TweenProcessMode.TWEEN_PROCESS_IDLE) -> Tween:
	if tween:
		tween.kill()
	return tween_empty(object, ease_type, trans_type, speed_scale, callback)


static func tween_empty(object: Node, ease_type := Tween.EASE_IN_OUT,
		trans_type := Tween.TRANS_LINEAR, speed_scale := 1.0,
		callback := Tween.TweenProcessMode.TWEEN_PROCESS_IDLE) -> Tween:
	var tween := object.create_tween()
	tween.set_ease(ease_type)
	tween.set_trans(trans_type)
	tween.set_speed_scale(speed_scale)
	tween.set_process_mode(callback)
	return tween


static func tween_ex(object: CanvasItem, property: NodePath, final_val: Variant,
		duration: float, delay := 0.0, ease_type := Tween.EASE_IN_OUT,
		trans_type := Tween.TRANS_LINEAR, speed_scale := 1.0,
		callback := Tween.TweenProcessMode.TWEEN_PROCESS_IDLE,
		interpolator := Callable()) -> Tween:
	var tween := tween_empty(object, ease_type, trans_type, speed_scale,
			callback)
	tween.tween_property(object, property, final_val,
			duration).set_delay(delay).set_custom_interpolator(interpolator)
	return tween


static func tween_modulate_alpha(object: CanvasItem, alpha: float,
		duration: float, delay := 0.0, ease_type := Tween.EASE_IN_OUT,
		trans_type := Tween.TRANS_LINEAR, speed_scale := 1.0,
		callback := Tween.TweenProcessMode.TWEEN_PROCESS_IDLE,
		interpolator := Callable()) -> Tween:
	return tween_ex(object, "modulate:a", alpha, duration, delay, ease_type,
			trans_type, speed_scale, callback, interpolator)


static func tween_self_modulate_alpha(object: CanvasItem, alpha: float,
		duration: float, delay := 0.0, ease_type := Tween.EASE_IN_OUT,
		trans_type := Tween.TRANS_LINEAR, speed_scale := 1.0,
		callback := Tween.TweenProcessMode.TWEEN_PROCESS_IDLE,
		interpolator := Callable()) -> Tween:
	return tween_ex(object, "self_modulate:a", alpha, duration, delay,
			ease_type, trans_type, speed_scale, callback, interpolator)


static func fade_in(object: CanvasItem, duration: float) -> Tween:
	return tween_modulate_alpha(object, 1.0, duration)


static func fade_in_ex(object: CanvasItem, duration: float, delay := 0.0,
		ease_type := Tween.EASE_IN_OUT, trans_type := Tween.TRANS_LINEAR,
		speed_scale := 1.0,
		callback := Tween.TweenProcessMode.TWEEN_PROCESS_IDLE,
		interpolator := Callable()) -> Tween:
	return tween_modulate_alpha(object, 1.0, duration, delay, ease_type,
			trans_type, speed_scale, callback, interpolator)


static func fade_in_ex_self_modulate(object: CanvasItem, duration: float,
		delay := 0.0, ease_type := Tween.EASE_IN_OUT,
		trans_type := Tween.TRANS_LINEAR, speed_scale := 1.0,
		callback := Tween.TweenProcessMode.TWEEN_PROCESS_IDLE,
		interpolator := Callable()) -> Tween:
	return tween_self_modulate_alpha(object, 1.0, duration, delay, ease_type,
			trans_type, speed_scale, callback, interpolator)


static func fade_out(object: CanvasItem, duration: float) -> Tween:
	return tween_modulate_alpha(object, 0.0, duration)


static func fade_out_ex(object: CanvasItem, duration: float, delay := 0.0,
		ease_type := Tween.EASE_IN_OUT, trans_type := Tween.TRANS_LINEAR,
		speed_scale := 1.0,
		callback := Tween.TweenProcessMode.TWEEN_PROCESS_IDLE,
		interpolator := Callable()) -> Tween:
	return tween_modulate_alpha(object, 0.0, duration, delay,
			ease_type, trans_type, speed_scale, callback, interpolator)


static func fade_out_ex_self_modulate(object: CanvasItem, duration: float,
		delay := 0.0, ease_type := Tween.EASE_IN_OUT,
		trans_type := Tween.TRANS_LINEAR, speed_scale := 1.0,
		callback := Tween.TweenProcessMode.TWEEN_PROCESS_IDLE,
		interpolator := Callable()) -> Tween:
	return tween_self_modulate_alpha(object, 0.0, duration, delay,
			ease_type, trans_type, speed_scale, callback, interpolator)


static func tween_modulate(object: CanvasItem, color: Color, duration: float,
		delay := 0.0, ease_type := Tween.EASE_IN_OUT,
		trans_type := Tween.TRANS_LINEAR, speed_scale := 1.0,
		callback := Tween.TweenProcessMode.TWEEN_PROCESS_IDLE,
		interpolator := Callable()) -> Tween:
	return tween_ex(object, "modulate", color, duration, delay,
			ease_type, trans_type, speed_scale, callback, interpolator)


static func tween_loops(object: CanvasItem, property: NodePath,
		first_val: Variant, second_val: Variant, duration: float, delay := 0.0,
		loops := 0, ease_type := Tween.EASE_IN_OUT,
		trans_type := Tween.TRANS_LINEAR, speed_scale := 1.0,
		callback := Tween.TweenProcessMode.TWEEN_PROCESS_IDLE,
		interpolator := Callable()) -> Tween:
	assert(duration > 0.0, "duration cannot be zero")
	var tween := tween_empty(object, ease_type, trans_type, speed_scale,
			callback)
	tween.set_loops(loops)
	tween.tween_interval(delay)
	tween.tween_property(object, property, first_val,
			duration).set_custom_interpolator(interpolator)
	tween.tween_property(object, property, second_val,
			duration).set_custom_interpolator(interpolator)
	return tween


static func blink(object: CanvasItem, duration: float, delay := 0.0,
		ease_type := Tween.EASE_IN_OUT, trans_type := Tween.TRANS_LINEAR,
		speed_scale := 1.0,
		callback := Tween.TweenProcessMode.TWEEN_PROCESS_IDLE) -> Tween:
	return tween_loops(object, "modulate:a", 0.0, 1.0, duration, delay, 0,
			ease_type, trans_type, speed_scale, callback)


static func blink_ex(object: CanvasItem, duration: float, min_alpha: float,
		max_alpha: float, delay := 0.0, ease_type := Tween.EASE_IN_OUT,
		trans_type := Tween.TRANS_LINEAR, speed_scale := 1.0,
		callback := Tween.TweenProcessMode.TWEEN_PROCESS_IDLE) -> Tween:
	return tween_loops(object, "modulate:a", min_alpha, max_alpha, duration,
			delay, 0, ease_type, trans_type, speed_scale, callback)


static func feature(object: CanvasItem, scale: float, duration: float,
		ease_type := Tween.EASE_IN_OUT, trans_type := Tween.TRANS_LINEAR,
		speed_scale := 1.0,
		callback := Tween.TweenProcessMode.TWEEN_PROCESS_IDLE) -> Tween:
	var duration_half := duration / 2.0
	var tween := tween_empty(object, ease_type, trans_type, speed_scale,
			callback)
	tween.tween_property(object, "scale", Vector2.ONE * scale, duration_half)
	tween.tween_property(object, "scale", Vector2.ONE, duration_half)
	return tween


static func feature_ex(object: CanvasItem, scale: float, duration_in: float,
		duration_out: float, ease_type := Tween.EASE_IN_OUT,
		trans_type := Tween.TRANS_LINEAR, speed_scale := 1.0,
		callback := Tween.TweenProcessMode.TWEEN_PROCESS_IDLE) -> Tween:
	var tween := tween_empty(object, ease_type, trans_type, speed_scale,
			callback)
	tween.tween_property(object, "scale", Vector2.ONE * scale, duration_in)
	tween.tween_property(object, "scale", Vector2.ONE, duration_out)
	return tween


static func interpolator_snapped(value: float, step: float) -> float:
	return snappedf(value, step)
