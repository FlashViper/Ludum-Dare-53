extends Node

var direction : Vector2
var direction_slerped : Vector2

var jump : bool
var jump_held : bool
var dive : bool
var charge_launch : bool

func _process(delta: float) -> void:
	direction = Input.get_vector(
		"left", "right", "up", "down"
	)
	
	direction = direction.normalized()
	direction_slerped = direction_slerped.slerp(direction, 0.15)
	charge_launch = Input.is_action_pressed("launch")
	
	jump = Input.is_action_just_pressed("jump")
	jump_held = Input.is_action_pressed("jump")
	dive = Input.is_action_just_pressed("dive")
