extends Node

class_name MovementModule

@export var speed: float = 350.0

@export var body: CharacterBody2D

func move(direction: Vector2, delta: float) -> void:
	body.velocity = direction * delta * speed * 25

func _physics_process(delta: float) -> void:
	body.move_and_slide()
