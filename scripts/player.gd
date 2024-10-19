extends CharacterBody2D

class_name Player

@export var input: PlayerInputModule
@export var movement: MovementModule

func _physics_process(delta: float) -> void:
	move_and_slide()
