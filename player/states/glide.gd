extends PlayerState

signal glide_finished


func _gameplay(delta: float) -> void:
	var acceleration := Player.GLIDE_ACCEL
	var max_speed := Player.GLIDE_SPEED
	var fall_rate := Player.FALL_RATE
	
	if absf(InputManager.direction.x) > 0:
		player.direction = signi(roundi(InputManager.direction.x))
	
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
	
	player.velocity_z = move_toward(
		player.velocity_z,
		-player.FALL_RATE,
		player.GRAVITY_GLIDE * delta
	)
	player.height += player.velocity_z * delta
	
	if player.height <= 0 or !InputManager.jump_held:
		glide_finished.emit()
		exit_to("Movement")


func _enter() -> void:
	player.velocity_z = 1.24
	player.visual.on_glide()


func _exit() -> void:
	player.visual.on_landed()
