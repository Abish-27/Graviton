extends Node2D


	# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Bgmusic.stream_paused = false
	%circle.play('default')
	%shadow.play('default')


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
