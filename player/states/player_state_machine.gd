extends Node

var current_state : PlayerState
var states : Array[PlayerState]
var state_name_mapping : Dictionary


func initialize(player: Player) -> void:
	for i in get_child_count():
		var obj := get_child(i)
		if obj is PlayerState:
			state_name_mapping[obj.name] = obj
			states.append(obj)
			obj.player = player
			obj.transition_requested.connect(set_state_by_name)
			obj._initialize()
	
#	$Glide.glide_finished.connect(set_state_by_name.bind("Movement"))
#	$Launch.launched.connect(set_state_by_name.bind("Glide"))


func on_physics_process(delta: float) -> void:
	for s in states:
		if s != current_state:
			if s._request_focus():
				if s._get_priority() >= current_state._get_priority():
					set_state_by_name(s.name)
				break
	
	if current_state:
		current_state._gameplay(delta)


func _unhandled_input(event: InputEvent) -> void:
	if current_state:
		current_state._on_input(event)


func set_state_by_index(id: int) -> void:
	if current_state:
		current_state._exit()
	
	if id >= 0 and id < states.size():
		current_state = states[id]
		current_state._enter()


func set_state_by_name(p_name: String) -> void:
	if current_state:
		current_state._exit()
	
	if state_name_mapping.has(p_name):
		current_state = state_name_mapping[p_name]
		current_state._enter()
