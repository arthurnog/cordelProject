class_name Movement
extends Node

@onready var player: Player = get_parent()

func move(direction: Vector2, delta: float) -> void:
	player.velocity.x = direction.x * player.speed
	player.velocity.y = direction.y * player.speed

func apply(delta: float) -> void:
	player.move_and_slide()
