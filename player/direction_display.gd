extends Node2D

@onready var root_pos := $Pivot.position.length() as float

func hide_tutorial() -> void:
	$Tutorial.hide()


func shake(node: Node2D, strength : float, root := Vector2()) -> void:
	var angle := randf() * TAU
	node.position = root + randf() * strength * Vector2(cos(angle), sin(angle))


func display_charge(amount: float, direction: Vector2) -> void:
	%Base.modulate = lerp(Color.WHITE, Color.GREEN, amount)
	%Arrow.position.x = lerpf(0, 128, amount)
	shake(%Base, amount * 10)
	shake(%Sprite2D, amount * 10)
	
	var dir : Vector2 = $Pivot.position.normalized()
	$Pivot.position = root_pos * dir.slerp(direction, 0.1)
	$Pivot.rotation = $Pivot.position.angle()


func show_tutorial() -> void:
	$Tutorial.modulate.a = 0
	$Tutorial.show()
	create_tween().tween_property($Tutorial, "modulate:a", 1.0, 0.25)
