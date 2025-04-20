extends Area2D

var parent : CharacterBody2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	parent = get_parent()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var bodies = get_overlapping_bodies()
	var direction = parent.gravity_direction
	for body in bodies:
		if body is CharacterBody2D:
			body.inField = true
			body.gravity_direction = direction
			
			
			
			
func stasis():
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body is CharacterBody2D and body != parent:
			body.reset()
			
			
