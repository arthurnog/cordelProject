extends CharacterBody2D

class_name Player

const FLIPPED_SPRITE_X_OFFSET = -32

@export var input: PlayerInputModule
@export var movement: MovementModule
@export var combat: CombatModule
@export var body: Node2D
@export var animator: AnimationPlayer
@export var sprite: Sprite2D
@export var state_machine: StateMachine
