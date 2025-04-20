extends CharacterBody2D

var speed = 250
var direction = Vector2.RIGHT
var tag = 'mini'
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	self.velocity = direction * speed
	rotation += velocity.length() * delta * 0.06
	move_and_slide()
	
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		var other = collision.get_collider()
		if other is StaticBody2D:
			queue_free()
		elif other is CharacterBody2D:
			if other.tag == 'player':
				other.lose_life()
				queue_free()

	
