extends Node2D

@export var score_template := "+%s points"
@export var score_template_multi := "x%s: +%s points"

@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var score_text: Label = %ScoreText


func flash(score: int, combo_amount := -1) -> void:
	$Text.rotation_degrees = randf_range(-5, 5)
	%ScoreText.text = (
		score_template_multi if combo_amount > 0 else score_template
	) % ([combo_amount, score] if combo_amount > 0 else [score])

	$AnimationPlayer.play("popup")
