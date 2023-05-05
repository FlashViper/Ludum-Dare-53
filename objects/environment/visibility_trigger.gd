extends Area2D

@export var target : CanvasItem


func _ready() -> void:
	body_entered.connect(show_deco.unbind(1))
	body_exited.connect(hide_deco.unbind(1))

func show_deco() -> void:
	if get_overlapping_bodies().size() > 0:
		set_alpha(0.511)


func hide_deco() -> void:
	print(get_overlapping_bodies().size())
	if get_overlapping_bodies().size() < 1:
		set_alpha(1.0)


func set_alpha(new: float) -> void:
	if !target:
		return
	
	create_tween().tween_property(
		target, "modulate:a", new, 0.15
	)
