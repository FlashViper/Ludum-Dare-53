extends Node2D

var t_appear_time := 0.0
var appeared : bool



func update_score(new: int, amount: int) -> void:
	$Root/Label.text = str(new)
	
	if amount > 0:
		$ScoreAnim.play("collect")
		
		if !appeared:
			appeared = true
			$AppearAnim.play("Appear")
			t_appear_time = 5


func _process(delta: float) -> void:
	t_appear_time -= delta
	
	if appeared:
		if t_appear_time < 0:
			appeared = false
			$AppearAnim.play("Disappear")
