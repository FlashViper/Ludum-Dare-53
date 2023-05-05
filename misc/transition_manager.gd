extends CanvasLayer

signal screen_hidden

func begin_transition() -> void:
	$AnimationPlayer.play("wipe")

func emit_flag() -> void:
	screen_hidden.emit()
