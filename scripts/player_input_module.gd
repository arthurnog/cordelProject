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
	basic_attack()
	jump()
	if(jump_buffer_count > 0.0):
		jump_buffer_count -= delta
		if(jump_buffer_count < 0.0): jump_buffer_count = 0.0

# Use MovementModule
func move_horizontal(delta: float) -> void:
	var movement_input: Vector2 = Vector2(
		Input.get_axis(LEFT_ACTION, RIGHT_ACTION),
		Input.get_axis(UP_ACTION, DOWN_ACTION)
	)
	player.movement.move(movement_input, delta)

# Use MovementModule
func jump() -> void:
	if(Input.is_action_just_pressed(JUMP_ACTION)):
		jump_buffer_count = JUMP_BUFFER_DURATION
	if(jump_buffer_count > 0.0 and player.movement.can_jump):
		player.movement.jump()
		jump_buffer_count = 0.0

# Use CombatModule
func basic_attack() -> void:
	if(Input.is_action_just_pressed(ATTACK_ACTION)):
	# 	attack_buffer_count = ATTACK_BUFFER_DURATION
	# if(attack_buffer_count > 0.0 and player.combat.can_attack):
	# 	print_debug(attack_buffer_count)
		player.combat.basic_attack()
