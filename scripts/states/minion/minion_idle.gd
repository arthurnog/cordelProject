extends State
class_name MinionIdleState

@onready var body: Minion = get_parent().get_parent()

var target_position: Vector2 = Vector2.ZERO
var attack_distance = 160
var last_flip: int = 1
var _transitioning := false

func start() -> void:
	_transitioning = false
	calculate_target_position()

func update(delta: float) -> void:
	if _transitioning: return
	calculate_target_position()  # recalcula todo frame
	
	var difference = target_position - body.global_position
	var distance = difference.length()
	var distance_to_player = (body.player.position - body.position).length()

	if distance_to_player <= body.minimum_distance_to_player or distance < 5.0:
		_transitioning = true
		body.can_attack = !body.can_attack
		transition.emit(self, "wait")
		
func physics_update(delta: float) -> void:
	if body.is_hurt:
		return
	var direction = (target_position - body.global_position).normalized()
	
	if abs(direction.x) > 0.3:
		var new_flip = 1 if direction.x > 0 else -1
		if new_flip != last_flip:
			last_flip = new_flip
			body.flip_sprite(direction)
			body.damage_emitter.scale.x = new_flip
	
	body.movement.move(direction, delta)
	body.animator.play("nonato_comum/walk")
	
func calculate_target_position() -> void:
	if body.can_attack:
		var side = 1 if body.global_position.x < body.player.global_position.x else -1
		target_position = body.player.global_position + Vector2(attack_distance * -side, 0)
	else:
		# Recua para uma posição fixa relativa ao player, não ao próprio body
		var away_dir = (body.global_position - body.player.global_position).normalized()
		target_position = body.player.global_position + away_dir * 200