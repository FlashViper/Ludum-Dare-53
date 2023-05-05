extends PanelContainer

signal to_title
signal restart

const FORMATTER := "%04d"
@export var countup_time := 3.0
@export var countup_curve : Curve
@onready var score_text: Label = %ScoreText
@onready var high_score_text: Label = %HighScoreText


func _ready() -> void:
	%Restart.pressed.connect(func(): restart.emit())
	%Title.pressed.connect(func(): to_title.emit())

func appear(score: int, high_score: int) -> void:
	show()
	high_score_text.text = FORMATTER % high_score
	display_score(score, high_score)

func display_score(score: int, high_score : int) -> void:
	score_text.text = FORMATTER % 0
	var score_nominal := 0.0
	var t_countup := 0.0
	
	while t_countup < 1:
		t_countup += get_process_delta_time()
		
		score_nominal = lerpf(0, score, countup_curve.sample(t_countup))
		score_text.text = FORMATTER % score_nominal
		
		await get_tree().process_frame
	
	$AnimationPlayer.play("score")
	await $AnimationPlayer.animation_finished
	if score > high_score:
		high_score_text.text = FORMATTER % score
		$AnimationPlayer.queue("high_score")
