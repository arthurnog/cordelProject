extends State
class_name MinionPunchState

@onready var body: Minion = get_parent().get_parent()

func start() -> void:
	body.movement.move(Vector2.ZERO, 0.0)
	body.animator.play("minion_comum/punch")
	body.animator.animation_finished.connect(_on_animation_finished)

func _on_animation_finished(anim_name: StringName) -> void:
	if anim_name == "minion_comum/punch":
		body.animator.animation_finished.disconnect(_on_animation_finished)
		transition.emit(self, "wait")
