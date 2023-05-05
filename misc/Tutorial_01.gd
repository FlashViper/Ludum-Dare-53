extends Node2D


func _ready() -> void:
	$Area2D.body_entered.connect(toggle_tutorial)


var toggled := false
func toggle_tutorial(_area) -> void:
	if !toggled:
		$Appear.play("appear")
		toggled = true
