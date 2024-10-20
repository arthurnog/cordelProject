extends Node

class_name CombatModule

@export_category("Nodes")
@export var body: CharacterBody2D
@export var sprite: Sprite2D
@export var attack_timer: Timer

@export_category("Attack")
@export var can_attack: bool = true
#Idle state: 0
#Basic attack combo states: 1,2,3
@export var attack_state: int = 0

func basic_attack() -> void:
	attack_timer.start()
	if attack_state == 3:
		attack_state = 1
	else:
		attack_state += 1
	print_debug("basic_attack ",attack_state)

#attack_timer is a place holder
#replace with animation timeout
func _on_attack_timer_timeout() -> void:
	attack_state = 0
