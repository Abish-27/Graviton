extends Button

var tween
var base_pos: Vector2

func _ready():
	base_pos = position
	float_up_and_down()

func float_up_and_down():
	tween = create_tween()
	var offset = 25
	var duration = 1.0

	# Go up
	tween.tween_property(self, "position", base_pos + Vector2(0, -offset), duration)\
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

	# Go down
	tween.tween_property(self, "position", base_pos, duration)\
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

	# When done, repeat
	tween.tween_callback(Callable(self, "float_up_and_down"))
