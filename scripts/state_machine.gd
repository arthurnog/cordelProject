extends Node

class_name StateMachine

@export var initial_state: State

var states: Dictionary = {}
var current_state: State

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.transition.connect(change_state)

func initialize(initial: State) -> void:
	current_state = initial
	current_state.start()

func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)
	
func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)
	
func change_state(caller: State, new_state: StringName) -> void:
	if caller != current_state or new_state.to_lower() not in states.keys(): return
	current_state.end()
	current_state = states[new_state.to_lower()]
	current_state.start()
