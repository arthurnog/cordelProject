extends State

class_name MinionAttackState

@onready var body: Minion = get_parent().get_parent()

var target_position: Vector2 = Vector2.ZERO
var direction: Vector2 = Vector2.ZERO

var attack_count = 0

func start() -> void:
	calculate_target_position()

func update(delta: float) -> void:
	var difference = target_position - body.global_position
	var distance = difference.length()
	direction = difference.normalized()
	var distance_to_player = (body.player.position - body.position).length()
	if attack_count >= 2: #ataca 2 vezes e depois recua
		body.can_attack = false
		transition.emit(self, "wait")
	if distance_to_player <= body.minimum_distance_to_player or distance < 5.0:
		body.can_attack = !body.can_attack
		transition.emit(self, "wait")

func physics_update(delta: float) -> void:
	body.movement.move(direction, delta)
	body.animator.play("player_walk")

func calculate_target_position():
	if body.sprite.flip_h:
		target_position = body.player.global_position + Vector2(body.attack_distance,0)
	else:
		target_position = body.player.global_position - Vector2(body.attack_distance,0)
