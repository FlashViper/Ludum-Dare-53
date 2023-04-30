extends Node

var paused : bool
var t_hitstop_duration : float

func _ready() -> void:
	process_mode = PROCESS_MODE_ALWAYS


func hitstop(duration: float) -> void:
	t_hitstop_duration = duration


func _process(delta: float) -> void:
	if !paused:
		t_hitstop_duration -= delta
	
	get_tree().paused = paused or t_hitstop_duration > 0
