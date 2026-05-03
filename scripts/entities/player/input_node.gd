class_name PlayerInput
extends Node

func get_movement_direction() -> Vector2:
	return Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

func is_attack_just_pressed() -> bool:
	return Input.is_action_just_pressed("p_attack")

func is_jump_just_pressed() -> bool:
	return Input.is_action_just_pressed("p_jump")
