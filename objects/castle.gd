extends Node2D

signal scored(points: int)


func _ready() -> void:
	$ScoreTrigger.area_entered.connect(on_ball_entered)


func on_ball_entered(ball: Area2D) -> void:
	ball.get_parent().queue_free()
	scored.emit(10)
