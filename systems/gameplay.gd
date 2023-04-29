extends Node

const TIME_STRING := "%01d:%02d"

enum {
	STATE_PREGAME,
	STATE_LAUNCHING,
	STATE_GAMEPLAY,
	STATE_FINISHED,
}

@export var time_per_round := 60.0

@onready var camera: Camera2D = $CameraRig

var score : int
var state : int
var time_remaining : float


func _ready() -> void:
	camera.set_target($Player, true)
	$Castle.scored.connect(on_scored)
	update_score()
	
	init_game()
	start_game()


func on_scored(points: int) -> void:
	score += points
	update_score()


func update_score() -> void:
	$GUI/Score/Label.text = str(score)


func _process(delta: float) -> void:
	if state == STATE_GAMEPLAY:
		time_remaining -= delta
	
		if time_remaining < 0:
			time_remaining = 0
			finish_game()
		
		$GUI/Score/Label.text = TIME_STRING % [
			floorf(time_remaining / 60),
			fmod(time_remaining, 60)
		]
	

func init_game() -> void:
	time_remaining = time_per_round
	$Player.position = Vector2(866, 683)
	$Player.reset()


func start_game() -> void:
	state = STATE_GAMEPLAY


func finish_game() -> void:
	state = STATE_FINISHED
	print("GAME FINISHED with score ", score)
	var p := $Player
	remove_child(p)
	
	await get_tree().create_timer(1.0).timeout
	
	add_child(p)
	init_game()
