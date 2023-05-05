extends PlayerState

signal finished_dive

var t_duration : float
var t_cooldown : float

func _enter() -> void:
	var dir := InputManager.direction
	var closest_angle := PI
	
	# Aim assist
	for t in get_tree().get_nodes_in_group("Target"):
		var node_dir := t.position - player.position as Vector2
		if node_dir.length() < Player.AUTOTARGET_DIST:
			if acos(node_dir.normalized().dot(dir)) < Player.AUTOTARGET_ANGLE:
				if closest_angle < cos(node_dir.normalized().dot(dir)):
					continue
				dir = node_dir.normalized()
				closest_angle = cos(node_dir.normalized().dot(dir))
				break
	
	player.visual.on_dive()
	if player.velocity.dot(dir) + Player.DIVE_SPEED > Player.DIVE_SPEED:
		player.velocity += Player.DIVE_SPEED * dir
	else:
		player.velocity = Player.DIVE_SPEED * dir
	t_duration = 0.0


func _gameplay(delta: float) -> void:
	t_duration += delta
	
	if t_duration > Player.DIVE_DURATION:
		finished_dive.emit()
		player.velocity = player.velocity.limit_length(Player.WALK_SPEED)
		t_cooldown = Player.DIVE_COOLDOWN
		exit_to("Movement")
	else:
		if InputManager.jump and player.height < Player.COLLISION_HEIGHT:
			player.velocity_z = 5
			player.height = 0.0001
			exit_to("Movement")


func _request_focus() -> bool:
	t_cooldown -= get_physics_process_delta_time()
	return InputManager.dive and t_cooldown <= 0
