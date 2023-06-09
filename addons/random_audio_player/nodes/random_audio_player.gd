@icon("random_audio_player.svg") 
@tool
class_name RandomAudioPlayer
extends Node2D

## Assigns the value to all the children as an overwrite.
@export var volume_Db_overwrite = 0.0:
	set(new_value):
		volume_Db_overwrite = new_value
		var children = get_children_of_type(self)
		for child in children: 
			child.set_volume_db(new_value)
			
## Assigns the value to all the children as an overwrite.
@export var max_distance_overwrite = 0.0:
	set(new_value):
		max_distance_overwrite = new_value
		var children = get_children_of_type(self)
		for child in children: 
			child.set_max_distance(new_value)

var random = RandomNumberGenerator.new()

func _ready():
	randomize()

func play():
	if get_child_count() < 1:
		return
	random.randomize()
	var randomIndex = random.randi_range(0, get_child_count() - 1)
	var player = get_child(randomIndex)
	if player.has_method("play"):
		player.play()

static func get_children_of_type(node: Node):
	var list = []
	for i in range(node.get_child_count()):
		var child = node.get_child(i)
		if child is AudioStreamPlayer2D:
			list.append(child)
	return list

func _get_configuration_warnings():
	var has_valid_children = false
	if len(get_children_of_type(self)) < 1:
		return ["AudioStreamPlayer2D is required"]
	return []
	
