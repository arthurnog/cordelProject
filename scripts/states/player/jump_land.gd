extends State
class_name PlayerJumpLandState

@onready var player: Player = get_parent().get_parent()

func start() -> void:
	player.movement.move(Vector2.ZERO, 0.0)
	player.animator.play("takeoff")
	await player.animator.animation_finished
	var direction = player.input.get_movement_direction()
	if direction != Vector2.ZERO:
		transition.emit(self, "walk")
	else:
		transition.emit(self, "player_idle")

func physics_update(delta: float) -> void:
	player.movement.move(Vector2.ZERO, delta)
	player.movement.apply(delta)
