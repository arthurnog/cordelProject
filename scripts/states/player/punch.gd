extends State
class_name PlayerAttackState

@onready var player: Player = get_parent().get_parent()
@onready var damage_emitter := player.get_node("DamageEmitter")

var attack_timer: float = 0.0
var combo_triggered: bool = false

func start() -> void:
	player.animator.play("punch")
	attack_timer = 0.0
	combo_triggered = false
	

func update(delta: float) -> void:
	attack_timer += delta
	if attack_timer >= 0.4:
		end_attack()
		return
	if player.input.is_attack_just_pressed():
		combo_triggered = true
	if combo_triggered:
		return
	elif not combo_triggered and attack_timer >= 0.23:
		end_attack()
		return
	

func end_attack() -> void:
	var direction = player.input.get_movement_direction()
	if direction != Vector2.ZERO:
		transition.emit(self, "walk")
	else:
		transition.emit(self, "player_idle")
		
func physics_update(delta: float) -> void:
	player.movement.move(Vector2.ZERO, delta)
	player.movement.apply(delta)

func end() -> void:
	print("Saindo do estado de punch")
	# Desativar hitbox do ataque

func on_emit_damage(damage_receiver: DamageReceiver) -> void:
	damage_receiver.damage_received.emit(player.damage)
	print(damage_receiver)
