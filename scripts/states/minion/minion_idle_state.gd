extends State

class_name MinionIdleState

@onready var body: Minion = get_parent().get_parent()

var target_position: Vector2 = Vector2.ZERO
var direction: Vector2 = Vector2.ZERO

func start() -> void:
	calculate_target_position()
	#body.animator.play("player_walk")

func update(delta: float) -> void:
	var difference = target_position - body.global_position
	var distance = difference.length()
	direction = difference.normalized()
	var distance_to_player = (body.player.position - body.position).length()
	var direction_to_player = body.player.position.x - body.global_position.x
	if distance_to_player <= body.minimum_distance_to_player or distance < 5.0:
		transition.emit(self, "wait")
	if direction_to_player != 0: #inimigo irá se virar para o player
		var flip = direction_to_player < 0
		get_tree().create_timer(body.reaction_time).timeout.connect(_reaction_timer_timeout.bind(flip))

func physics_update(delta: float) -> void:
	#body.movement.move(direction, delta)
	pass

func calculate_target_position():
	var view_rect = get_viewport().get_visible_rect()
	target_position = Vector2(
		randf_range(view_rect.position.x, view_rect.end.x),
		randf_range(view_rect.position.y, view_rect.end.y)
	)

func _reaction_timer_timeout(flip) -> void:
	body.sprite.flip_h = flip
	body.sprite.position.x = Player.FLIPPED_SPRITE_X_OFFSET * int(flip)
