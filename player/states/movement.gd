extends PlayerState


func _gameplay(delta: float) -> void:
	player.velocity = InputManager.direction * Player.SPEED_WALK
