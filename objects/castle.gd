extends Node2D

signal scored(points: int)


func _ready() -> void:
	$ScoreTrigger.area_entered.connect(on_ball_entered)
	scored.connect($Visual/ScoreEffects.score.unbind(1))


func on_ball_entered(ball: Area2D) -> void:
	ball.get_parent().queue_free()
	%Yarn.modulate = ball.modulate
	$Score.play()
	
	scored.emit(10)
	
	await get_tree().create_timer(0.25).timeout
	$Meow.play()


func get_player_respawn() -> Node2D:
	return %Respawn


func get_launch_position() -> Vector2:
	return %LaunchPosition.global_position
