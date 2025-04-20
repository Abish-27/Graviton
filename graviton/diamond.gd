extends CharacterBody2D


var mini_triangle_scene = preload("res://mini_triangle.tscn")


var speed = 50.0
var gravity_direction: Vector2 = Vector2.ZERO
var drag = 0.999
var bounciness = 2 
var inField = false
var cooling = false
var tag = 'diamond'
var activated = false
#----DIAMOOOND-----

func _ready():
	randomize()  # Ensure randomness on every run
	var rand_angle = randf() * TAU
	var rand_dir = Vector2(cos(rand_angle), sin(rand_angle)).normalized()
	velocity = rand_dir * 10
	var delay = randf_range(0.5, 2.0) 
	await get_tree().create_timer(delay).timeout
	%diamood.play("default") 

	
func _physics_process(delta: float) -> void:
	
	if inField:
		if not activated:
			activated = true
			%shooter.start()
		# Apply gravity
		if gravity_direction != Vector2.ZERO:
			velocity += gravity_direction * speed * delta

		# Apply drag
		velocity *= drag

		# Set velocity and move
		self.velocity = velocity
		move_and_slide()

		# Bounce on collisions
		for i in get_slide_collision_count():
			var collision = get_slide_collision(i)
			if not cooling:
				var other = collision.get_collider()
				if other is CharacterBody2D:
					if "player" in other.name:
						doDamage(other)
						
			if collision:
				var normal = collision.get_normal()
				velocity = velocity.bounce(normal)
				self.velocity = velocity  # <-- This line ensures bounce continues next frame
		
		rotation += velocity.length() * delta * 0.04
	
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

func reset():
	gravity_direction = Vector2.ZERO
	_set_random_motion()


func _on_cooldown_timeout() -> void:
	cooling = false # Replace with function body.
	
func doDamage(other):
	other.lose_life()
	cooling = true
	%cooldown.start()


func _on_shooter_timeout() -> void:
	shoot_triangle()
	
func shoot_triangle():
	var projectile = mini_triangle_scene.instantiate()
	projectile.global_position = global_position
	var angle = randf() * TAU  # TAU = 2π
	var direction = Vector2(cos(angle), sin(angle)).normalized()
	projectile.direction = direction
	get_tree().current_scene.add_child(projectile)
	
	var projectile2 = mini_triangle_scene.instantiate()
	projectile2.global_position = global_position
	angle = randf() * TAU  # TAU = 2π
	direction = Vector2(cos(angle), sin(angle)).normalized()
	projectile2.direction = direction
	get_tree().current_scene.add_child(projectile2)
	
	
	
	
	
	
