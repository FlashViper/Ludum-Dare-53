extends Node

enum Modes {ONLY_IF_VISIBLE, TOGGLE_VISIBILITY}

@export var target : CanvasItem :
	set(new):
		target = new
		initial = target.visible
@export var mode : Modes
var initial : bool

func _ready() -> void:
	if !target:
		if get_parent() is CanvasItem:
			target = get_parent()
		else:
			printerr("ASODKOPSKDO (hide_on_debug.gd)")
			return
	
	PauseManager.pause_state_changed.connect(on_state_changed)


func on_state_changed() -> void:
	match mode:
		Modes.ONLY_IF_VISIBLE:
			target.visible = initial and !PauseManager.paused
		_:
			target.visible = !PauseManager.paused
