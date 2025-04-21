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
	if Checkpoint.get_checkpoint() != Vector2.ZERO:
		global_position = Checkpoint.get_checkpoint()
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
		
		if collision:
			var normal = collision.get_normal()
			velocity = velocity.bounce(normal)
			self.velocity = velocity 
		
		if other is CharacterBody2D:
			if other.tag in ['triangle', 'diamond']:
				if not other.cooling:
					other.doDamage(self)
			if other.tag in ['rectangle']:
				var normal = collision.get_normal()
				velocity = velocity.bounce(normal) * 1.2
				self.velocity = velocity
	
	rotation += velocity.length() * delta * 0.06
	
func _set_random_motion():
	var rand_angle = randf() * TAU
	var rand_dir = Vector2(cos(rand_angle), sin(rand_angle)).normalized()
	velocity = rand_dir * speed * 0.6

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
	$particle1.visible = true
	$particle2.visible = true
	$particle3.visible = true
	$particle4.visible = true
	$particle1.play('default')
	$particle2.play('default')
	$particle3.play('default')
	$particle4.play('default')
	
	lives -= 1
	if lives == 0:
		get_tree().change_scene_to_file("res://lose.tscn")
	panel.lose_life(lives)

func gravity_sound():
	%Gravity.play()
	
func stasis_sound():
	%Stasis.play()


func _on_particle_1_animation_looped() -> void:
	$particle1.stop()
	$particle1.visible = false


func _on_particle_4_animation_looped() -> void:
	$particle4.stop()
	$particle4.visible = false
	



func _on_particle_2_animation_looped() -> void:
	$particle2.stop()
	$particle2.visible = false


func _on_particle_3_animation_looped() -> void:
	$particle3.stop()
	$particle3.visible = false


	
