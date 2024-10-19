extends Node

class_name PlayerInputModule

@onready var player = get_parent()

const UP_ACTION = "p_up"
const DOWN_ACTION = "p_down"
const LEFT_ACTION = "p_left"
const RIGHT_ACTION = "p_right"
const JUMP_ACTION = "p_jump"
const ATTACK_ACTION = "p_attack"

const JUMP_BUFFER_DURATION: float = 0.5
var jump_buffer_count = 0.0


func _process(delta: float) -> void:
	move_horizontal(delta)
	jump()
	attack()

# Use MovementModule
func move_horizontal(delta: float) -> void:
	var movement_input: Vector2 = Vector2(
		Input.get_axis(LEFT_ACTION, RIGHT_ACTION),
		Input.get_axis(UP_ACTION, DOWN_ACTION)
	)
	player.movement.move(movement_input, delta)

# Use MovementModule
func jump() -> void:
	# TODO: Use jump buffer when MovementModule ground checkage is ready
	if(Input.is_action_just_pressed(JUMP_ACTION)):
		pass
		## Call MovementModule move function

# Use CombatModule
func attack() -> void:
	if(Input.is_action_just_pressed(ATTACK_ACTION)):
		pass
		## Call CombatModule attack action
