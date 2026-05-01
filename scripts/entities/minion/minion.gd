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

func _ready() -> void:
	super()
	damage_receiver.damage_received.connect(on_receive_damage.bind())
	state_machine.initialize(state_machine.initial_state)

func on_receive_damage(amount: int) -> void:
	health -= amount
	print(name, " tomou dano! HP: ", health)
