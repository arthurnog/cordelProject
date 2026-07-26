extends State
class_name MinionPunchState

@onready var body: Minion = get_parent().get_parent()

func start() -> void:
	body.movement.move(Vector2.ZERO, 0.0)
	body.animator.play("minion/punch")
	if not body.animator.animation_finished.is_connected(_on_animation_finished):
		body.animator.animation_finished.connect(_on_animation_finished)

func update(delta: float) -> void:
	if body.is_hurt:
		if body.animator.animation_finished.is_connected(_on_animation_finished):
			body.animator.animation_finished.disconnect(_on_animation_finished)
		transition.emit(self, "idle")

func _on_animation_finished(anim_name: StringName) -> void:
	if anim_name == "minion/punch":
		body.animator.animation_finished.disconnect(_on_animation_finished)
		body.intent_to_attack = false
		transition.emit(self, "idle")
