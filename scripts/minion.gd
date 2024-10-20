extends CharacterBody2D

class_name Minion

@export var movement: MovementModule

@onready var player: Player = get_parent().get_node("Player")
