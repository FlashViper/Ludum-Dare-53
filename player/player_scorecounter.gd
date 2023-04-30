extends Node2D

func update_score(new: int, amount: int) -> void:
	$Root/Label.text = str(new)
	$AnimationPlayer.play("collect")
