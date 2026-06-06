extends State
class_name MinionIdleState

@onready var body: Minion = get_parent().get_parent()

var target_position: Vector2 = Vector2.ZERO
var attack_distance = 80
var last_flip: int = 1
var position_offset: Vector2 = Vector2.ZERO 
var _transitioning := false

func start() -> void:
	_transitioning = false
	position_offset = Vector2(
		randf_range(-20.0, 20.0),  
		randf_range(-7.0, 7.0)    
	)
	calculate_target_position()

func update(delta: float) -> void:
	if _transitioning: return
	calculate_target_position()  # recalcula todo frame
	
	var dist_x = abs(body.player.global_position.x - body.global_position.x)
	if dist_x <= attack_distance:
		_transitioning = true
		body.intent_to_attack = randf() < 0.6
		print("OI")
		transition.emit(self, "wait")
		
func physics_update(delta: float) -> void:
	if body.is_hurt:
		return
	var direction = (target_position - body.global_position).normalized()
	
	var dir_to_player = body.player.global_position.x - body.global_position.x
	if dir_to_player != 0:
		var new_flip = 1 if dir_to_player > 0 else -1
		if new_flip != last_flip:
			last_flip = new_flip
			body.flip_sprite(Vector2(dir_to_player, 0))
			body.damage_emitter.scale.x = new_flip

	body.movement.move(direction, delta)
	body.animator.play("nonato_comum/walk")
	
func calculate_target_position() -> void:
	var player_center = body.player.global_position + Vector2(0, -40)  
	target_position = Vector2(
		player_center.x + position_offset.x,
		player_center.y + position_offset.y
	)
