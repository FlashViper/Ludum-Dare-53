extends Node


var mapping := {}

func _ready() -> void:
	for c in get_children():
		mapping[c.name] = c


func crossfade_names(a: String, b: String, time := 1.1) -> void:
	if !mapping.has(a) or !mapping.has(b):
		printerr("Invalid moozic (la la la) names")
		return
	
	crossfade(mapping[a], mapping[b], time)


func play(track: String) -> void:
	for c in get_children():
		if c.name == track:
			c.play()
		else:
			c.stream_paused = true


func crossfade(a: AudioStreamPlayer2D, b: AudioStreamPlayer2D, time := 1.1) -> void:
	var t := create_tween()
	t.tween_property(
		a, "volume_db", -100.0, time
	)
	t.parallel().tween_property(
		b, "volume_db", 0.0, time
	).from(-100.0).set_delay(time * 0.4)
	t.chain().tween_callback(func(): a.stream_paused = true)
	
	b.volume_db = -100
	b.play()
#	b.stream_paused = false
