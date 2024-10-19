extends Node

class_name EnemyNavigationModule

@onready var body = get_parent()
@onready var player = body.get_parent().get_node("Player")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var diff: Vector2 = player.position -  body.position
	diff = diff.normalized()
	body.movement.move(diff, delta)
