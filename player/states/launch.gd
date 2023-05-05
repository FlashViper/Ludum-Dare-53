extends PlayerState

signal launched

@export var launch_modifier : Curve
@export var max_time := 1.0


var t_power : float
var t_tutorial : float


func _ready() -> void:
	$DirectionDisplay.hide()


func _enter() -> void:
	player.body.z_index = 1
	
	player.visual.idle()
	player.velocity_z = 0
	player.height = 0
	t_tutorial = 0.0
	
	$DirectionDisplay.hide_tutorial()
	$DirectionDisplay.show()


func _exit() -> void:
	player.body.z_index = 0
	$DirectionDisplay.hide()


func _gameplay(delta: float) -> void:
	var dir := InputManager.prev_direction
	player.velocity = Vector2()
	
	if InputManager.charge_launch:
		t_power += delta
		t_tutorial = 0
	else:
		if t_power > 0.2:
			launch(dir.normalized())
		else:
			t_power -= 0
		
		t_tutorial += delta
		if t_tutorial > 5:
			$DirectionDisplay.show_tutorial()
	
	$DirectionDisplay.display_charge(launch_modifier.sample(t_power), dir.normalized())


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
