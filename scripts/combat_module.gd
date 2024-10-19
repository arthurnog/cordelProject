extends Node

class_name CombatModule

@export_category("Nodes")
@export var body: CharacterBody2D
@export var sprite: Sprite2D

@export_category("Atack")
@export var canAtack: bool = true
#Basic atack combo states: 0,1,2
@export var atackState: int = 0

func basicAtack() -> void:
	if body.atackState == 2:
		body.atackState = 0
	else:
		body.atackState += 1

#func _process(delta: float) -> void:

#func _physics_process(delta: float) -> void:
