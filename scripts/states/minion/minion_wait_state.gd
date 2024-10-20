extends State

class_name MinionWaitState

@onready var body: Minion = get_parent().get_parent()

func start() -> void:
	get_tree().create_timer(5.0).timeout.connect(timer_end)
	body.movement.move(Vector2.ZERO, 0.0) # Reset body velocity

func timer_end() -> void:
	transition.emit(self, "idle")
