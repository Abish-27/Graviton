extends Control

@export var player : CharacterBody2D 
@export var book : Node2D
var booked = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%shadow.play("default")
	%bubble.play("default")
	%life1.play("default")
	var delay = randf_range(0.5, 2.0) 
	await get_tree().create_timer(delay).timeout
	%life2.play("default")
	delay = randf_range(0.5, 1) 
	await get_tree().create_timer(delay).timeout
	%life3.play("default")
	

	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("reset"):
		_on_stasis_pressed()
	elif Input.is_action_just_pressed("up"):
		_on_up_pressed()
	elif Input.is_action_just_pressed("down"):
		_on_down_pressed()
	elif Input.is_action_just_pressed("left"):
		_on_left_pressed()
	elif Input.is_action_just_pressed("right"):
		_on_right_pressed()


func _on_right_pressed() -> void:
	player.gravity_sound()
	player.gravity_direction = Vector2.RIGHT
	$right.self_modulate = Color("ff75ff") 
	$stasis.self_modulate = Color('ffffff')
	await get_tree().create_timer(0.35).timeout
	$left.self_modulate = Color("ffffff")
	$up.self_modulate = Color("ffffff")
	$down.self_modulate = Color("ffffff")


func _on_up_pressed() -> void:
	player.gravity_sound()
	player.gravity_direction = Vector2.UP
	$up.self_modulate = Color("ff75ff")
	$stasis.self_modulate = Color('ffffff')
	await get_tree().create_timer(0.35).timeout
	$right.self_modulate = Color("ffffff") 
	$left.self_modulate = Color("ffffff")
	$down.self_modulate = Color("ffffff")
	


func _on_left_pressed() -> void:
	player.gravity_sound()
	player.gravity_direction = Vector2.LEFT # Replace with function body.
	$left.self_modulate = Color("ff75ff")
	$stasis.self_modulate = Color('ffffff')
	await get_tree().create_timer(0.35).timeout
	$right.self_modulate = Color("ffffff") 
	$up.self_modulate = Color("ffffff")
	$down.self_modulate = Color("ffffff")
	


func _on_down_pressed() -> void:
	player.gravity_sound()
	player.gravity_direction = Vector2.DOWN # Replace with function body.
	$down.self_modulate = Color("ff75ff")

	await get_tree().create_timer(0.35).timeout
	$right.self_modulate = Color("ffffff") 
	$left.self_modulate = Color("ffffff")
	$up.self_modulate = Color("ffffff")
	$stasis.self_modulate = Color('ffffff')


func _on_stasis_pressed() -> void:
	player.stasis_sound()
	#player.gravity_direction = Vector2.ZERO
	player.reset()
	$stasis.self_modulate = Color('bdbdbd')
	await get_tree().create_timer(0.35).timeout
	$right.self_modulate = Color("ffffff") 
	$left.self_modulate = Color("ffffff")
	$up.self_modulate = Color("ffffff")
	$down.self_modulate = Color("ffffff")
	
func lose_life(lives):
	if lives == 2:
		%life1.visible = false
	elif lives == 1:
		%life2.visible = false
	elif lives == 0:
		%life3.visible = false


func _on_book_button_pressed() -> void:
	
	if not booked:
		%bookaudio.play()
		book.visible = true
		booked = true
	else:
		book.visible = false
		booked = false
		


func _on_home_button_pressed() -> void:
	get_tree().change_scene_to_file("res://home.tscn")
