class_name Minion
extends Entity

@onready var movement := $Movement
@onready var state_machine := $StateMachine
@onready var damage_receiver := $DamageReceiver

func _ready() -> void:
	super()
	damage_receiver.damage_received.connect(on_receive_damage.bind())
	state_machine.initialize(state_machine.initial_state)

func on_receive_damage(amount: int) -> void:
	health -= amount
	print(name, " tomou dano! HP: ", health)
