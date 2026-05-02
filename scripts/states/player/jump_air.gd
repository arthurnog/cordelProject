extends State
class_name PlayerJumpAirState

@onready var player: Player = get_parent().get_parent()

const GRAVITY = 450.0
const FALL_MULTIPLIER = 2.0

func start() -> void:
	player.animator.play("jump")


func update(delta: float) -> void:
	player.height_spped -= GRAVITY * (1.0 if player.height_spped > 0 else FALL_MULTIPLIER) * delta
	player.height += player.height_spped * delta
	player.entity_sprite.position.y = -player.height

	if player.height <= 0.0:
		player.height = 0.0
		player.height_spped = 0.0
		player.entity_sprite.position.y = 0.0
		transition.emit(self, "jump_land")

func physics_update(delta: float) -> void:
	var direction = player.input.get_movement_direction()
	var flip = player.flip_sprite(direction)
	if flip != 0:
		player.damage_emitter.scale.x = flip
	player.movement.move(direction, delta)
	player.movement.apply(delta)
