extends State
class_name PlayerWalkState

@onready var player: Player = get_parent().get_parent()
@onready var damage_emitter := player.get_node("DamageEmitter")

func start() -> void:
	player.animator.play("walk")

func update(delta: float) -> void:
	if player.input.is_attack_just_pressed():
		transition.emit(self, "punch")
		return
	if player.input.get_movement_direction() == Vector2.ZERO:
		transition.emit(self, "player_idle")
		return
	if player.input.is_jump_just_pressed():
		transition.emit(self, "jump_start")
	return



func physics_update(delta: float) -> void:
	var direction = player.input.get_movement_direction()
	var flip = player.flip_sprite(direction)
	if flip != 0:
		damage_emitter.scale.x = flip
	player.movement.move(direction, delta)
	player.movement.apply(delta)
	
func end() -> void:
	pass
