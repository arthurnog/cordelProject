extends Node

class_name MinionMovement

@export var source: CharacterBody2D
@export var body: Node2D

@export_category("Horizontal Movement")

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
	source.velocity = direction * source.speed
	source.move_and_slide()

func jump():
	velocity_h = jump_force

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	pass
