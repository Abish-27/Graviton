extends CharacterBody2D

#---rectangle--
var speed = 70.0
var gravity_direction: Vector2 = Vector2.ZERO
var drag = 0.998
var bounciness = 2
var inField = false
var tag = 'rectangle'


func _ready():
	randomize()  # Ensure randomness on every run
	var rand_angle = randf() * TAU
	var rand_dir = Vector2(cos(rand_angle), sin(rand_angle)).normalized()
	velocity = rand_dir * 10
	var delay = randf_range(0.5, 2.0) 
	await get_tree().create_timer(delay).timeout
	%yawner.play('default')
	
func _physics_process(delta: float) -> void:
		
	if inField:
		# Apply gravity
		if gravity_direction != Vector2.ZERO:
			velocity += gravity_direction * 150 * delta

		# Apply drag
		velocity *= drag

		# Set velocity and move
		self.velocity = velocity
		move_and_slide()

		# Bounce on collisions
		for i in get_slide_collision_count():
			var collision = get_slide_collision(i)
			if collision:
				var normal = collision.get_normal()
				velocity = velocity.bounce(normal)
				self.velocity = velocity  # <-- This line ensures bounce continues next frame
			
				var other = collision.get_collider()
				if other is CharacterBody2D:
					other.velocity.bounce(normal) * 2
					other.velocity *= 1.4
					
		rotation += velocity.length() * delta * 0.01

func reset():
	gravity_direction = Vector2.ZERO
	_set_random_motion()
	
func _set_random_motion():
	var rand_angle = randf() * TAU
	var rand_dir = Vector2(cos(rand_angle), sin(rand_angle)).normalized()
	velocity = rand_dir * speed

func move_up():
	gravity_direction = Vector2.UP
	
func move_down():
	gravity_direction = Vector2.DOWN
	
func move_right():
	gravity_direction = Vector2.RIGHT
	
func move_left():
	gravity_direction = Vector2.LEFT
