extends State
class_name PlayerAttackState

@onready var player: Player = get_parent().get_parent()

var attack_timer: float = 0.0
var attack_duration: float = 0.2  # Duração do ataque em segundos

func start() -> void:
	print("👊 Entrou no estado ATTACK")
	player.animator.play("punch")
	attack_timer = 0.0
	

func update(delta: float) -> void:
	attack_timer += delta
	
	# Verificar se a animação de ataque já terminou
	if attack_timer >= attack_duration:
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
	print("👊 Saindo do estado ATTACK")
	# Desativar hitbox do ataque
	
