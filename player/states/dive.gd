extends PlayerState

signal finished_dive

var t_duration : float
var t_cooldown : float

func _enter() -> void:
	player.velocity = Player.DIVE_SPEED * InputManager.direction
	t_duration = 0.0


func _gameplay(delta: float) -> void:
	t_duration += delta
	
	if t_duration > Player.DIVE_DURATION:
		finished_dive.emit()
		t_cooldown = Player.DIVE_COOLDOWN
		exit_to("Movement")
	else:
		if InputManager.jump:
			player.height = 1
			exit_to("Movement")


func _request_focus() -> bool:
	t_cooldown -= get_physics_process_delta_time()
	return InputManager.dive and t_cooldown <= 0
