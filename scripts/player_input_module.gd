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
var jump_buffer_count: float = 0.0

func _process(delta: float) -> void:
	# Atualizar buffer do pulo
	if jump_buffer_count > 0.0:
		jump_buffer_count -= delta
		if jump_buffer_count < 0.0:
			jump_buffer_count = 0.0

# Retorna a direção de movimento
func get_movement_direction() -> Vector2:
	return Vector2(
		Input.get_axis(LEFT_ACTION, RIGHT_ACTION),
		Input.get_axis(UP_ACTION, DOWN_ACTION)
	)

# Verifica se o botão de pulo foi pressionado
func is_jump_just_pressed() -> bool:
	return Input.is_action_just_pressed(JUMP_ACTION)

# Verifica se o botão de ataque foi pressionado
func is_attack_just_pressed() -> bool:
	return Input.is_action_just_pressed(ATTACK_ACTION)

# Verifica se tem pulo no buffer
func has_jump_buffered() -> bool:
	return jump_buffer_count > 0.0

# Consome o buffer do pulo (chamar quando o pulo for executado)
func consume_jump_buffer() -> void:
	jump_buffer_count = 0.0

# Adiciona pulo ao buffer (chamar quando pressionar pulo)
func add_jump_buffer() -> void:
	if Input.is_action_just_pressed(JUMP_ACTION):
		jump_buffer_count = JUMP_BUFFER_DURATION
