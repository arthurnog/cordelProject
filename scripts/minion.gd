extends CharacterBody2D

class_name Minion

@export var movement: MovementModule

@export var minimum_distance_to_player: float = 10.0
@export var animator: AnimationPlayer
@export var sprite: Sprite2D

# Stats do inimigo
@export_category("Stats")
@export var max_health: int = 50
@export var defense: int = 0
@export var invincibility_duration: float = 0.5

@onready var player: Player = get_parent().get_node("Player")
@onready var damage_receiver: DamageReceiver = $DamageReceiver

var current_health: int
var is_invincible: bool = false

func _ready() -> void:
	current_health = max_health
	
	damage_receiver.damage_received.connect(_on_damage_received)
		
func start_invincibility() -> void:
	is_invincible = true
	
	# Efeito visual de piscar
	var tween = create_tween()
	tween.set_loops(6)
	tween.tween_property(sprite, "modulate", Color.RED, 0.1)
	tween.tween_property(sprite, "modulate", Color.WHITE, 0.1)
	
	# Timer para desativar invencibilidade
	await get_tree().create_timer(invincibility_duration).timeout
	is_invincible = false
	sprite.modulate = Color.WHITE

func take_damage(damage: int) -> void:
	if is_invincible:
		return
	
	# Calcular dano final com defesa
	var final_damage = max(1, damage - defense)
	current_health -= final_damage
	
	print("Minion sofreu ", final_damage, " de dano | HP: ", current_health, "/", max_health)
	
	# Ativar invencibilidade
	if invincibility_duration > 0:
		start_invincibility()
	if current_health <= 0:
		die()
	
func die() -> void:
	print("💀 Minion morreu!")
	
	# Desativar colisão
	$CollisionShape2D.disabled = true
	
	# Efeito de morte
	var tween = create_tween()
	tween.tween_property(sprite, "modulate", Color.RED, 0.2)
	tween.tween_property(sprite, "modulate", Color.TRANSPARENT, 0.2)
	await tween.finished
	
	queue_free()

func _on_damage_received(damage: int) -> void:
	take_damage(damage)
