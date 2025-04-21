extends Area2D


func _on_body_entered(body):
	if body is CharacterBody2D:
		if body.tag == 'player':
			Checkpoint.set_checkpoint(global_position)
