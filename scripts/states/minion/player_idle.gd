extends State
class_name MinionIdleState2

@onready var player: Player = get_parent().get_parent()

func start() -> void:
	player.animator.play("idle")

func update(delta: float) -> void:
	if player.input.is_attack_just_pressed():
		transition.emit(self, "punch")
		return

	if player.input.get_movement_direction() != Vector2.ZERO:
		transition.emit(self, "walk")
		return

	#player.input.add_jump_buffer()
	#if player.input.has_jump_buffered() and player.movement.can_jump:
		#player.input.consume_jump_buffer()
		#transition.emit(self, "jump")
		#return

func physics_update(delta: float) -> void:
	player.movement.move(Vector2.ZERO, delta)
	player.movement.apply(delta)

func end() -> void:
	pass
