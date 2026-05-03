extends Camera2D
@export var player : CharacterBody2D

func _process(delta: float) -> void:
	if player.position.x > position.x:
		position.x = player.position.x
