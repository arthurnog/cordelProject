extends State

class_name MinionIdleState

@onready var body: Minion = get_parent().get_parent()

var target_position: Vector2 = Vector2.ZERO
var direction: Vector2 = Vector2.ZERO

func start() -> void:
	calculate_target_position()

func update(delta: float) -> void:
	var difference = target_position - body.global_position
	var distance = difference.length()
	direction = difference.normalized()
	
	if distance < 5.0:
		transition.emit(self, "wait")

func physics_update(delta: float) -> void:
	body.movement.move(direction, delta)

func calculate_target_position():
	var view_rect = get_viewport().get_visible_rect()
	target_position = Vector2(
		randf_range(view_rect.position.x, view_rect.end.x),
		randf_range(view_rect.position.y, view_rect.end.y)
	)
