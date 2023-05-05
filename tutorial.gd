extends Node2D

signal finished


func _ready() -> void:
	%Castle.scored.connect(on_score)


var score := 0
func on_score(_score) -> void:
	score += 1
	
	if score >= 3:
		finished.emit()
