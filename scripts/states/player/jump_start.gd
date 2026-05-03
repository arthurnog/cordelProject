extends State
class_name PlayerJumpStartState

@onready var player: Player = get_parent().get_parent()

func start() -> void:
	player.animator.play("takeoff")
	player.height_spped = player.jump_force
	await player.animator.animation_finished
	transition.emit(self, "jump_air")

func physics_update(delta: float) -> void:
	player.movement.move(player.input.get_movement_direction(), delta)
	player.movement.apply(delta)
