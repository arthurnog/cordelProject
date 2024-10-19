extends Node

class_name EnemyNavigationModule

enum MinionMovementState {
	MISS_PLAYER,
	REACH_PLAYER_SIDE
}

@onready var body: CharacterBody2D = get_parent()
@onready var player: Player = body.get_parent().get_node("Player")

## Distance (in units), in which the minion will miss the player position
@export var player_miss_radius: float = 6.0

var target_position: Vector2 = Vector2.ZERO
var player_side_desired_distance: float = 128
var minimum_distance_to_target: float = 64.0
var movement_state: MinionMovementState:
	set(value):
		match(value):
			MinionMovementState.MISS_PLAYER:
				set_miss_position()
			MinionMovementState.REACH_PLAYER_SIDE:
				set_side_position()

static var rng = RandomNumberGenerator.new()

func _ready():
	await get_tree().create_timer(5).timeout
	set_miss_position()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var diff: Vector2 = target_position -  body.position
	if diff.length() > minimum_distance_to_target:
		diff = diff.normalized()
		body.movement.move(diff, delta)
	else:
		body.movement.move(Vector2.ZERO, delta)
		match(movement_state):
			MinionMovementState.MISS_PLAYER:
				movement_state = MinionMovementState.REACH_PLAYER_SIDE
			MinionMovementState.REACH_PLAYER_SIDE:
				var y_diff = body.position.x - player.position.x
				y_diff = clampf(y_diff, -1, 1)
				body.movement.move(y_diff, delta)

# Set target position to random position around player
func set_miss_position():
	var miss_vector = Vector2(player_miss_radius, 0.0)
	miss_vector.rotated(90)
	target_position = player.position + miss_vector
# Set target position to closest player side
func set_side_position():
	var x_diff = player.position.x - body.position.x
	x_diff = -clampf(x_diff, -1, 1)
	target_position = player.position
	target_position.x += player_side_desired_distance * x_diff
