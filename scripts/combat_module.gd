extends Node

class_name CombatModule

@onready var damage_emitter := get_node("../DamageEmitter")
var damage = 10

func _ready() -> void:
	damage_emitter.area_entered.connect(on_emit_damage.bind())
	
func on_emit_damage(damage_receiver: DamageReceiver):
	damage_receiver.damage_received.emit(damage)
