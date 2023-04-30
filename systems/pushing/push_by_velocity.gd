extends "res://systems/pushing/push_box.gd"

@export var body : CharacterBody2D
@export var strength := 1000

func _process(delta: float) -> void:
	visible = monitorable


func _get_direction(to: Node2D) -> Vector2:
	var dir := (to.position - global_position).normalized()
	if body:
		if body.velocity.length() > 10:
			return body.velocity.normalized().project(dir).normalized()
		else:
			return dir
	else:
		return dir


func _get_strength() -> float:
	if body:
		return body.velocity.length() + strength
	else:
		return 0.0
