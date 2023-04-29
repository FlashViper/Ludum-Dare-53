extends Control

signal play_pressed
signal about_pressed


func _ready() -> void:
	%Menu.item_pressed.connect(on_item_pressed)


func on_item_pressed(item: String) -> void:
	match item:
		"Play": play_pressed.emit()
		"About": about_pressed.emit()
