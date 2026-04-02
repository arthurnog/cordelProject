extends Node2D

@onready var player := $Player
@onready var camera := $Camera2D
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player.position.x > camera.position.x:
		camera.position.x = player.position.x
