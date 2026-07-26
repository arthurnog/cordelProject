class_name Player
extends Entity

@onready var input := $PlayerInput
@onready var movement := $Movement
@onready var state_machine := $StateMachine
@onready var enemy_slots : Array = $EnemySlots.get_children()

func _ready() -> void:
	super()
	state_machine.initialize(state_machine.initial_state)
	damage_emitter.area_entered.connect(func(area): print("COLIDIU COM: ", area.name))

func reserve_slot(minion: Minion) -> EnemySlot:
	var available_slots := enemy_slots.filter(
		func(slot): return slot.is_free()
	)
	if available_slots.size() == 0:
		return null
	available_slots.sort_custom(
		func(a: EnemySlot, b: EnemySlot) -> int:
			var a_distance := (minion.global_position - a.global_position).length()
			var b_distance := (minion.global_position - b.global_position).length()
			return a_distance < b_distance
	)
	available_slots[0].occupy_slot(minion)
	return available_slots[0]

func free_slot(minion: Minion) -> void:
	var target_slots := enemy_slots.filter(
		func(slot): return slot.occupant == minion
	)
	if target_slots.size() == 1:
		target_slots[0].free_slot()
