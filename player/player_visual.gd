extends Node2D

var player : Player


func _process(delta: float) -> void:
	$Body.position.y = player.height * -100
