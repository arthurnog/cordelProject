extends State

class_name MinionWaitState

@onready var body: Minion = get_parent().get_parent()

func start() -> void:
	#timer para trocar de estado
	get_tree().create_timer(body.change_state_time).timeout.connect(timer_end)
	body.movement.move(Vector2.ZERO, 0.0) # Reset body velocity
	body.animator.play("player_idle")

func update(delta: float) -> void:
	var distance_to_player = (body.position - body.player.position).length()
	
	if distance_to_player < body.minimum_distance_to_player:
		transition.emit(self, "idle") # TODO: Replace with attack state

func timer_end() -> void:
	transition.emit(self, "idle")
