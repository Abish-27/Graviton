extends Node2D

var checkpoint_position: Vector2 = Vector2.ZERO

func set_checkpoint(pos: Vector2):
	checkpoint_position = pos

func get_checkpoint() -> Vector2:
	return checkpoint_position
