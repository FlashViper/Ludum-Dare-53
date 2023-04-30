extends Node

@export var scene : PackedScene
@export var radius_inner := 600
@export var radius_outer := 4500

func initialize() -> void:
	spawn(50)


func spawn(amount: int) -> void:
	for c in get_children():
		remove_child(c)
		c.queue_free()
	
	for i in amount:
		var angle := randf() * TAU
		var radius := randf_range(radius_inner, radius_outer)
		
		var obj := scene.instantiate()
		obj.position = Vector2(cos(angle), sin(angle)) * radius
		
		add_child(obj)
	
