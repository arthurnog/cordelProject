extends State
class_name PlayerIdleState

@onready var player: Player = get_parent().get_parent()

func start() -> void:
	player.animator.play("player_idle")

func update(delta: float) -> void:
	var direction = player.input.get_movement_direction()
	if direction != Vector2.ZERO:  
		transition.emit(self, "walk")
		return
		
	if player.input.is_attack_just_pressed():
		transition.emit(self, "punch")
		return
	
	# Verificar pulo (com buffer)
	player.input.add_jump_buffer()
	if player.input.has_jump_buffered() and player.movement.can_jump:
		player.input.consume_jump_buffer()
		transition.emit(self, "jump")
		return

func physics_update(delta: float) -> void:
	# Parado, sem movimento
	player.movement.move(Vector2.ZERO, delta)
	player.movement._physics_process(delta)
