class_name EnemySlot
extends Node2D

var occupant : Minion = null

func is_free() -> bool:
	return occupant == null

func free_slot() -> void:
	occupant = null

func occupy_slot(minion: Minion) -> void:
	occupant = minion