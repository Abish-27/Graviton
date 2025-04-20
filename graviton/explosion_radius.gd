extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func explode():
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body is CharacterBody2D:
			if 'player' in body.name:
				body.lose_life()
			else:
				body.queue_free()
