extends State
class_name MinionIdleState

@onready var body: Minion = get_parent().get_parent()
var player_slot : EnemySlot = null

var attack_distance = 40
var last_flip: int = 1
var position_offset: Vector2 = Vector2.ZERO 
var _transitioning := false

func start() -> void:
	_transitioning = false

func update(delta: float) -> void:
	if _transitioning: return

	if player_slot == null:
		player_slot = body.player.reserve_slot(body)

	if player_slot != null:		
		var dist_x = abs(player_slot.global_position.x - body.global_position.x)
		if dist_x <= attack_distance:
			_transitioning = true
			body.intent_to_attack = randf() < 0.6
			print("OI")
			transition.emit(self, "wait")
	
		
func physics_update(delta: float) -> void:
	if(player_slot == null):
		body.animator.play("minion/idle")
		return
	if body.is_hurt:
		return
	print("player_slot: ", player_slot)
	var direction = (player_slot.global_position - body.global_position).normalized()
	
	var dir_to_player = body.player.global_position.x - body.global_position.x
	if dir_to_player != 0:
		var new_flip = 1 if dir_to_player > 0 else -1
		if new_flip != last_flip:
			last_flip = new_flip
			body.flip_sprite(Vector2(dir_to_player, 0))
			body.damage_emitter.scale.x = new_flip

	body.movement.move(direction, delta)
	body.animator.play("minion/walk")
	
