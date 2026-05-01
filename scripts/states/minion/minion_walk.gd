extends State
class_name MinionWaitState

@onready var body: Minion = get_parent().get_parent()

func start() -> void:
	body.movement.move(Vector2.ZERO, 0.0)
	body.animator.play("player_idle")
	
	# vira pro player uma vez só
	var direction_to_player = body.player.position.x - body.global_position.x
	if direction_to_player != 0:
		var flip = direction_to_player < 0
		get_tree().create_timer(body.reaction_time).timeout.connect(
			func(): _reaction_timer_timeout(flip)
		)
	
	get_tree().create_timer(body.change_state_time).timeout.connect(timer_end)

func update(delta: float) -> void:
	var distance_to_player = (body.position - body.player.position).length()
	if distance_to_player < body.minimum_distance_to_player:
		transition.emit(self, "idle")

func timer_end() -> void:
	transition.emit(self, "idle")

func _reaction_timer_timeout(flip: bool) -> void:
	body.entity_sprite.flip_h = flip
