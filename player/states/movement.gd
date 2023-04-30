extends PlayerState

var t_enter_glide : float


func _gameplay(delta: float) -> void:
	var accel := Player.WALK_ACCEL
	var speed := Player.WALK_SPEED
	
	if absf(InputManager.direction.x) > 0:
		player.direction = signi(roundi(InputManager.direction.x))

	if player.velocity.length() > speed:
		if player.height > Player.COLLISION_HEIGHT:
			accel = Player.AIR_DECEL
		else:
			accel = Player.GROUND_DECEL
	elif (
			InputManager.direction.dot(InputManager.direction_slerped) < cos(PI / 2) or
			InputManager.direction_slerped.length() < 0.45
		):
		accel = Player.WALK_BOOST
	elif player.velocity.dot(InputManager.direction) < 0:
		accel = Player.WALK_DIR_CHANGE

	player.velocity = player.velocity.move_toward(
		InputManager.direction * speed,
		accel * delta
	)
	
	
	if player.height <= 0:
		if player.height < 0:
			player.visual.on_landed()
		player.height = 0
		player.velocity_z = 0
	else:
		player.velocity_z -= Player.GRAVITY * delta
		if player.velocity_z < 0 and InputManager.jump_held:
			t_enter_glide += delta
			if t_enter_glide > 0.116667: # ~~ 7 frames
				exit_to("Glide")
		else:
			t_enter_glide = 0
			
	
	player.height += player.velocity_z * delta
	
	
	if InputManager.direction.length() > 0:
		if player.height < 0.1:
			player.visual.on_walk()
	else:
		player.visual.idle()
	
	if InputManager.jump and player.height < Player.COLLISION_HEIGHT:
		player.velocity_z = Player.JUMP_SPEED
		player.height += 0.001
		player.velocity += player.velocity.normalized() * Player.JUMP_BOOST
		player.visual.on_jump()
	
