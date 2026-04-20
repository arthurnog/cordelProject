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
	# Verificar se a animação de ataque já terminou
	if not combo_triggered and attack_timer <= 0.25:
		if player.input.is_attack_just_pressed():
			combo_triggered = true
			damage_emitter.scale.x *= 1.1
			
	
	# Se fez combo, ataque dura 0.4 segundos (tempo para o segundo soco)
	if combo_triggered and attack_timer >= 0.35:
		damage_emitter.scale.x /= 1.1
		end_attack()
		return
	
	# Se não fez combo, ataque dura 0.2 segundos (animação normal)
	if not combo_triggered and attack_timer >= 0.2:
		end_attack()
		return

func end_attack() -> void:
	var direction = player.input.get_movement_direction()
	if direction != Vector2.ZERO:
		transition.emit(self, "walk")
	else:
		transition.emit(self, "player_idle")
		
func physics_update(delta: float) -> void:
	# Player não se move durante o ataque (opcional)
	# Se quiser que ele possa se mover durante o ataque, descomente:
	# var direction = player.input.get_movement_direction()
	# player.movement.move(direction, delta)
	# player.movement._physics_process(delta)
	
	# Parado durante o ataque:
	player.movement.move(Vector2.ZERO, delta)
	player.movement._physics_process(delta)

func end() -> void:
	print("Saindo do estado de punch")
	# Desativar hitbox do ataque
	
