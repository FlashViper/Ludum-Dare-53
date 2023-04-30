extends "res://systems/pushing/push_box.gd"

@export var strength := 1000

func _get_direction(to: Node2D) -> Vector2:
	return (to.global_position - global_position).normalized()


func _get_strength() -> float:
	return strength
