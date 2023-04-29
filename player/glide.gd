extends PlayerState

signal glide_finished


func _enter() -> void:
	player.height = Player.STARTING_HEIGHT


func _gameplay(delta: float) -> void:
	var acceleration := Player.GLIDE_ACCEL
	var max_speed := Player.GLIDE_SPEED
	var fall_rate := Player.FALL_RATE
	
	if InputManager.direction.length() < 0.2:
		acceleration = Player.GLIDE_DECEL
		fall_rate = Player.FALL_RATE_STATIONARY
	elif player.velocity.normalized().dot(InputManager.direction) < 0:
		acceleration = Player.GLIDE_COUNTERSTEER
	elif player.velocity.length() > max_speed:
		acceleration = Player.GLIDE_SLOWDOWN
	
	player.velocity = player.velocity.move_toward(
		InputManager.direction * max_speed,
		acceleration * delta
	)
	
	player.height = move_toward(
		player.height,
		0,
		fall_rate * delta
	)
	
	if player.height <= 0:
		glide_finished.emit()
