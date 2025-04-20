extends CharacterBody2D

#----PLAYER------
var speed = 200
var gravity_direction: Vector2 = Vector2.ZERO
var drag = 0.99
var bounciness = 1.2 
var inField = true
var lives = 3
var tag = 'player'

@export var panel : Control


func _ready():
	randomize()  # Ensure randomness on every run
	var rand_angle = randf() * TAU
	var rand_dir = Vector2(cos(rand_angle), sin(rand_angle)).normalized()
	velocity = rand_dir * 10
	%circle.play('default')
	
func _physics_process(delta: float) -> void:	
		
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
		var other = collision.get_collider()
		if other is CharacterBody2D:
			if other.tag in ['triangle', 'diamond']:
				if not other.cooling:
					other.doDamage(self)
		if collision:
			var normal = collision.get_normal()
			velocity = velocity.bounce(normal)
			self.velocity = velocity  # <-- This line ensures bounce continues next frame
	
	rotation += velocity.length() * delta * 0.06
	
func _set_random_motion():
	var rand_angle = randf() * TAU
	var rand_dir = Vector2(cos(rand_angle), sin(rand_angle)).normalized()
	velocity = rand_dir * speed * 0.5

func reset():
	gravity_direction = Vector2.ZERO
	_set_random_motion()
	%Field.stasis()
	
func move_up():
	gravity_direction = Vector2.UP
	
func move_down():
	gravity_direction = Vector2.DOWN
	
func move_right():
	gravity_direction = Vector2.RIGHT
	
func move_left():
	gravity_direction = Vector2.LEFT

func lose_life():
	lives -= 1
	panel.lose_life(lives)
	
