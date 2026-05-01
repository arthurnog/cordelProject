class_name Entity
extends CharacterBody2D

@export var health: int
@export var damage: int
@export var speed: int

@onready var entity_sprite := $EntitySprite
@onready var animator := $AnimationPlayer
@onready var damage_emitter := $DamageEmitter

func _ready() -> void:
	damage_emitter.area_entered.connect(on_emit_damage)	
func flip_sprite(vel: Vector2) -> int:
	if vel.x > 0:
		entity_sprite.flip_h = false
		return 1
	elif vel.x < 0:
		entity_sprite.flip_h = true
		return -1
	return 0;

func on_emit_damage(damage_receiver : DamageReceiver) -> void:
	damage_receiver.damage_received.emit(damage)
