extends State
class_name MinionWaitState

@onready var body: Minion = get_parent().get_parent()
var reaction_timer: SceneTreeTimer
var state_timer: SceneTreeTimer

func start() -> void:
	body.movement.move(Vector2.ZERO, 0.0)
	body.animator.play("nonato_comum/idle")
	
	# vira pro player uma vez só
	var direction_to_player = body.player.position.x - body.global_position.x
	if direction_to_player != 0:
		var flip = direction_to_player < 0
		reaction_timer = get_tree().create_timer(body.reaction_time)
		reaction_timer.timeout.connect(func(): _reaction_timer_timeout(flip))
	
	if body.intent_to_attack:
		state_timer = get_tree().create_timer(randf_range(0.2, 0.5))
		state_timer.timeout.connect(func(): transition.emit(self, "punch"))
	else:
		state_timer = get_tree().create_timer(randf_range(0.8, 1.5))
		state_timer.timeout.connect(func(): transition.emit(self, "idle"))

func end() -> void:
	# Invalida os callbacks pendentes
	reaction_timer = null
	state_timer = null

func update(delta: float) -> void:
	if body.is_hurt:
		end()
		transition.emit(self, "idle")

func timer_end() -> void:
	if state_timer == null: return
	transition.emit(self, "idle")

func _reaction_timer_timeout(flip: bool) -> void:
	if reaction_timer == null: return
	body.entity_sprite.flip_h = flip
	body.damage_emitter.scale.x = -1 if flip else 1
