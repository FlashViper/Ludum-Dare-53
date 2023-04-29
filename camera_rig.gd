extends Camera2D

var target : Node2D


func _process(delta: float) -> void:
	if target:
		position = position.lerp(
			target.position, 0.1
		)


func set_target(new: Node2D, snap := false) -> void:
	target = new
	
	if snap:
		position = new.position
