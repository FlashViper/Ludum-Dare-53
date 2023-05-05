class_name ColorPalette
extends Resource

@export var colors : Array[Color] = []


func get_random() -> Color:
	return colors[randi() % colors.size()]
