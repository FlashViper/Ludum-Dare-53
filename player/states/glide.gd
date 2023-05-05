extends PlayerState

signal glide_finished

var glide_initially_pressed : bool

func _gameplay(delta: float) -> void:
	var acceleration := Player.GLIDE_ACCEL
	var max_speed := Player.GLIDE_SPEED
	var glide_fall_speed := Player.FALL_RATE
	var fall_rate := Player.GRAVITY_GLIDE
	
	if absf(InputManager.direction.x) > 0:
		player.direction = signi(roundi(InputManager.direction.x))
	
	if InputManager.direction.length() < 0.2:
		acceleration = Player.GLIDE_DECEL
		glide_fall_speed = Player.FALL_RATE_STATIONARY
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
		-glide_fall_speed,
		fall_rate * delta
	)
	player.height += player.velocity_z * delta
	
	var pressing_glide := true
	pressing_glide = !glide_initially_pressed or InputManager.jump_held
	if !glide_initially_pressed:
		glide_initially_pressed = InputManager.jump_held
	
	if player.height <= 0 or !pressing_glide:
		glide_finished.emit()
		exit_to("Movement")
	
	player.camera_target.position.y = player.height * -100


func _enter() -> void:
	glide_initially_pressed = InputManager.jump_held
	
	if InputManager.jump_held:
		player.velocity_z = 1.24
	else:
		player.velocity_z = Player.FALL_RATE
	player.visual.on_glide()
	
	$TrackPlayer/Glide.play()


func _exit() -> void:
	player.camera_target.position.y = 0
	player.visual.on_landed()
