class_name Player
extends Entity

@export var maxHealth = 30

@onready var input := $PlayerInput
@onready var movement := $Movement
@onready var state_machine := $StateMachine
@onready var currentHealth: int = maxHealth

signal healthChanged #emitir sinal quando player sofre dano ou é curado

func _ready() -> void:
	self.health = maxHealth
	super()
	state_machine.initialize(state_machine.initial_state)
	damage_emitter.area_entered.connect(func(area): print("COLIDIU COM: ", area.name))
