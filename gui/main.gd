extends Node

@export var title_scene : PackedScene
@export var gameplay_scene : PackedScene


var title : Node
var gameplay : Node


func _ready() -> void:
	title = title_scene.instantiate()
	title.play_pressed.connect(on_play_pressed)
	add_child(title)


func on_play_pressed() -> void:
	title.queue_free()
	
	gameplay = gameplay_scene.instantiate()
	add_child(gameplay)
