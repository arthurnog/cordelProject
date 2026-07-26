class_name Minion
extends Entity

@onready var movement := $Movement
@onready var state_machine := $StateMachine
@onready var damage_receiver := $DamageReceiver
@export var player: Player

@export var change_state_time: float = 1.5
@export var reaction_time: float = 0.2
@export var minimum_distance_to_player: float = 10.0
var intent_to_attack: bool = true
var is_hurt: bool = false

func _ready() -> void:
	super()
	damage_receiver.damage_received.connect(on_receive_damage.bind())
	state_machine.initialize(state_machine.initial_state)

func on_receive_damage(amount: int) -> void:
	if is_hurt: return
	health -= amount
	is_hurt = true
	movement.move(Vector2.ZERO, 0.0)
	animator.stop()
	animator.play("minion/damage")
	if health <= 0:
		queue_free()
		return
	animator.animation_finished.connect(_on_damage_animation_finished, CONNECT_ONE_SHOT)
	is_hurt = false

func _on_damage_animation_finished(anim_name: StringName) -> void:
	if anim_name == "minion/damage":
		is_hurt = false