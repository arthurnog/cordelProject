class_name Minion
extends Entity

@onready var movement := $Movement
@onready var state_machine := $StateMachine
@onready var damage_receiver := $DamageReceiver
@export var player: Player

@export var change_state_time: float = 1.5
@export var reaction_time: float = 0.2
@export var minimum_distance_to_player: float = 10.0
var can_attack: bool = true
var is_hurt: bool = false

func _ready() -> void:
	super()
	damage_receiver.damage_received.connect(on_receive_damage.bind())
	state_machine.initialize(state_machine.initial_state)

func on_receive_damage(amount: int) -> void:
	health -= amount
	is_hurt = true
	movement.move(Vector2.ZERO, 0.0)
	animator.stop()
	animator.play("nonato_comum/damage")
	if health <= 0:
		queue_free()
	await animator.animation_finished
	is_hurt = false
