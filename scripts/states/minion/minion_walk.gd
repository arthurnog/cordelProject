extends State
class_name MinionWalkState

@onready var player: Minion = get_parent().get_parent()
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
	
	## Verificar pulo (com buffer)
	#player.input.add_jump_buffer()
	#if player.input.has_jump_buffered() and player.movement.can_jump:
		#player.input.consume_jump_buffer()
		#transition.emit(self, "jump")
		#return


func physics_update(delta: float) -> void:
	var direction = player.input.get_movement_direction()
	player.flip_sprite(direction)
	player.movement.move(direction, delta)
	player.movement.apply(delta)
	
func end() -> void:
	pass
