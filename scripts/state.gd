extends Node

class_name State

signal transition(caller: State, new_state: StringName)

func start() ->  void:
	pass

func update(delta: float) -> void:
	pass
	
func physics_update(delta: float) -> void:
	pass
	
func end() -> void:
	pass
