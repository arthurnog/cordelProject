extends CharacterBody2D

class_name Minion

@export var movement: MovementModule

@export var minimum_distance_to_player: float = 10.0
@export var animator: AnimationPlayer

@onready var player: Player = get_parent().get_node("Player")
