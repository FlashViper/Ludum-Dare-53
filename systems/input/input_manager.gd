extends Node

var direction : Vector2
var charge_launch : bool


func _process(delta: float) -> void:
	direction = Input.get_vector(
		"left", "right", "up", "down"
	)
	
	direction = direction.normalized()
	charge_launch = Input.is_action_pressed("launch")
