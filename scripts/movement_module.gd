extends Node

class_name MovementModule

@export_category("Nodes")
@export var body: CharacterBody2D
@export var sprite: Sprite2D

@export_category("Horizontal Movement")
@export var speed: float = 350.0

@export_category("Jump")
@export var gravity = 450
@export var fall_gravity_multiplier = 2
@export var jump_force: float = 500.0

var can_jump:
	get:
		return height == 0

var height: float = 0.0
var velocity_h: float = 0.0

func move(direction: Vector2, delta: float) -> void:
	body.velocity = direction * delta * speed * 25

func jump():
	velocity_h = jump_force

func _process(delta: float) -> void:
	sprite.position.y = -height

func _physics_process(delta: float) -> void:
	body.move_and_slide()
	height += velocity_h * delta
	if velocity_h > 0:
		velocity_h -= gravity * delta
	else:
		velocity_h -= gravity * fall_gravity_multiplier * delta 
	if height < 0: height = 0.0
