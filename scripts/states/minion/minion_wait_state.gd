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
	var direction_to_player = body.player.position.x - body.global_position.x

	body.can_attack = !body.can_attack
	if distance_to_player > body.attack_distance:
		body.can_attack = true
	elif distance_to_player <= body.attack_distance:
		body.can_attack = false

	if direction_to_player != 0: #inimigo irá se virar para o player
		var flip = direction_to_player < 0
		get_tree().create_timer(body.reaction_time).timeout.connect(_reaction_timer_timeout.bind(flip))
	
	if distance_to_player < body.minimum_distance_to_player:
		if body.can_attack:
			transition.emit(self, "attack") # Inimigo irá avançar
		else:
			transition.emit(self, "idle") # Inimigo irá recuar

func timer_end() -> void:
	if body.can_attack:
		transition.emit(self, "attack") # Inimigo irá avançar
	else:
		transition.emit(self, "idle") # Inimigo irá recuar

func _reaction_timer_timeout(flip) -> void:
	#body.can_attack = false
	body.sprite.flip_h = flip
	body.sprite.position.x = Player.FLIPPED_SPRITE_X_OFFSET * int(flip)
