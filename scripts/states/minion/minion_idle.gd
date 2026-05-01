extends State
class_name MinionIdleState

@onready var player: Minion = get_parent().get_parent()

func start() -> void:
	player.animator.play("nonato_comum/idle")

func update(delta: float) -> void:
	pass

	#player.input.add_jump_buffer()
	#if player.input.has_jump_buffered() and player.movement.can_jump:
		#player.input.consume_jump_buffer()
		#transition.emit(self, "jump")
		#return

func physics_update(delta: float) -> void:
	pass

func end() -> void:
	pass
