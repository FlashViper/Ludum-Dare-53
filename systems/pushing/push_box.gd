extends Area2D

signal hit(dir: Vector2, strength: float)

func _ready() -> void:
	add_to_group(&"PushBox")


func on_hit(direction: Vector2, strength: float) -> void:
	hit.emit(direction, strength)


func _get_direction(to: Node2D) -> Vector2: return Vector2()
func _get_strength() -> float: return 0.0
