extends Node

@export var scene : PackedScene
@export var radius_inner := 600
@export var radius_outer := 4500

func _ready() -> void:
	spawn(50)


func spawn(amount: int) -> void:
	var center : Vector2 = $Center.position
	
	for i in amount:
		var angle := randf() * TAU
		var radius := randf_range(radius_inner, radius_outer)
		
		var obj := scene.instantiate()
		obj.position = Vector2(cos(angle), sin(angle)) * radius
		obj.position += center
		
		add_child(obj)
	
