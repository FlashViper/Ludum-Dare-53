extends "res://systems/pushing/push_box.gd"

@export var direction : Vector2

func _get_direction(to: Node2D) -> Vector2:
	return direction.normalized()
