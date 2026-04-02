extends State
class_name PlayerWalkState

@onready var player: Player = get_parent().get_parent()
@onready var damage_emitter := player.get_node("DamageEmitter")

func start() -> void:
	player.animator.play("player_walk")

func update(delta: float) -> void:
	var direction = player.input.get_movement_direction()
	
	# Verificar se parou de andar
	if direction.x == 0 and direction.y == 0:
		transition.emit(self, "player_idle")
		return
	
	# Verificar pulo (com buffer)
	player.input.add_jump_buffer()
	if player.input.has_jump_buffered() and player.movement.can_jump:
		player.input.consume_jump_buffer()
		transition.emit(self, "jump")
		return
	
	if direction.x < 0:
		player.sprite.flip_h = true
		damage_emitter.scale.x = -1
	elif direction.x > 0:
		player.sprite.flip_h = false
		damage_emitter.scale.x = 1


func physics_update(delta: float) -> void:
	var direction = player.input.get_movement_direction()
	player.movement.move(direction, delta)
	player.movement._physics_process(delta)
