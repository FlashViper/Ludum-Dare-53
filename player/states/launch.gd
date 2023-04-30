extends PlayerState

signal launched

@export var launch_modifier : Curve
@export var max_time := 1.0


var t_power : float


func _enter() -> void:
	player.body.z_index = 1


func _exit() -> void:
	player.body.z_index = 0


func _gameplay(delta: float) -> void:
	player.velocity = Vector2()
	if InputManager.charge_launch:
		t_power += delta
	else:
		if t_power > 0.2:
			var dir := InputManager.direction
			if dir.length() < 0.1:
				dir = player.get_mouse_position() - player.position
			
			launch(dir.normalized())
		else:
			t_power -= 0


func launch(launch_dir : Vector2) -> void:
	player.velocity = Player.LAUNCH_SPEED * launch_dir
	player.velocity *= launch_modifier.sample(t_power / max_time)
	player.position.y -= (Player.STARTING_HEIGHT - 1) * -100
	player.height = Player.STARTING_HEIGHT
	t_power = 0
	
	launched.emit()
	exit_to("Glide")


func _get_priority() -> int:
	return 5
