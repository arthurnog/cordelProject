class_name Player
extends Entity

@onready var input := $PlayerInput
@onready var movement := $Movement
@onready var state_machine := $StateMachine

func _ready() -> void:
	super()
	state_machine.initialize(state_machine.initial_state)
	damage_emitter.area_entered.connect(func(area): print("COLIDIU COM: ", area.name))
