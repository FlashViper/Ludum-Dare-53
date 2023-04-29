extends PlayerState

var velocity_y : float


func _enter() -> void:
	velocity_y = 0


func _gameplay(delta: float) -> void:
	var accel := Player.WALK_ACCEL
	var speed := Player.WALK_SPEED

	if player.velocity.length() > speed:
		if player.height > Player.COLLISION_HEIGHT:
			accel = Player.AIR_DECEL
		else:
			accel = Player.GROUND_DECEL

	player.velocity = player.velocity.move_toward(
		InputManager.direction * speed,
		accel * delta
	)
	
	velocity_y -= Player.GRAVITY * delta
	player.height += velocity_y * delta
	
	if player.height < 0:
		player.height = 0
		velocity_y = 0
	
	
	if InputManager.jump and player.height < Player.COLLISION_HEIGHT:
		velocity_y = Player.JUMP_SPEED
		player.velocity += player.velocity.normalized() * Player.JUMP_BOOST
	
