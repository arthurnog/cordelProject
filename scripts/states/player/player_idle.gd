extends State
class_name PlayerIdleState

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
	
	if player.input.is_jump_just_pressed():
		transition.emit(self, "jump_start")
	return

func physics_update(delta: float) -> void:
	player.movement.move(Vector2.ZERO, delta)
	player.movement.apply(delta)

func end() -> void:
	pass
