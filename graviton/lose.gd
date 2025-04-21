extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Bgmusic.stream_paused = true
	$Lost.play()
	%shadow.play()
	%dying.play()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_home_button_pressed() -> void:
	get_tree().change_scene_to_file("res://home.tscn")


func _on_button_pressed():
	Bgmusic.stream_paused = false
	get_tree().change_scene_to_file("res://main.tscn")
