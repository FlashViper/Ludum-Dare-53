extends Node

signal pause_state_changed

var high_score := 0

var paused : bool
var t_hitstop_duration : float

func _ready() -> void:
	process_mode = PROCESS_MODE_ALWAYS
	set_process_input(true)


func hitstop(duration: float) -> void:
	t_hitstop_duration = duration


func _process(delta: float) -> void:
	if !paused:
		t_hitstop_duration -= delta
	
	get_tree().paused = paused or t_hitstop_duration > 0


func _input(event: InputEvent) -> void:
	if !OS.has_feature("editor"):
		return
	
	if event is InputEventKey:
		if event.is_pressed():
			if event.keycode == KEY_P or event.keycode == KEY_Q:
				paused = !paused
				pause_state_changed.emit()
