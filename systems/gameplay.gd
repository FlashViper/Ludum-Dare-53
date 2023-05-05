extends Node

const TIME_STRING := "%01d:%02d"
signal exit_to_menu
signal exit_to_secret

enum {
	STATE_PREGAME,
	STATE_LAUNCHING,
	STATE_GAMEPLAY,
	STATE_FINISHED,
}

@export var time_per_round := 60.0
@export var time_per_combo := 9.8 # Gravity is my favorite theory
@export var combo_bonus_score := 5
@export var combo_bonus_time := 15.0
@export var bonus_time_interval := 3
@export var combo_score_scene : PackedScene
@export var combo_time_scene : PackedScene 

@onready var camera: Camera2D = $Camera

var score : int
var state : int
var combo : int
var t_combo : float
var time_remaining : float


func _ready() -> void:
#	camera.set_target($Player, true)
	$Castle.scored.connect(on_scored)
	$Player.started_game.connect(start_game)
	%WinPanel.restart.connect(
		func():
			TransitionManager.begin_transition()
			await TransitionManager.screen_hidden
			init_game()
	)
	%WinPanel.to_title.connect(func(): exit_to_menu.emit())
	%EndGame.body_entered.connect(func(_thing): exit_to_secret.emit())

#	camera.add_target($Castle.get_player_respawn(), 0.5)
	camera.add_target($Player/CameraTarget, 2.0)
	
	init_game()


func on_scored(points: int) -> void:
	score += points + combo_bonus_score * combo
	
	var rando_position := $Player.position as Vector2
	if t_combo > 0 or combo < 1:
		combo += 1
		
		if combo > 1:
			var obj := combo_score_scene.instantiate()
			var angle := randf() * TAU
			rando_position += Vector2(cos(angle), sin(angle)) * randf_range(100, 400)
			obj.position = rando_position
			obj.flash(points + combo_bonus_score * combo, combo)
			add_child(obj)
	
	t_combo = time_per_combo
	
	if combo > 1 and combo % bonus_time_interval == 0:
		time_remaining += combo_bonus_time
		var obj := combo_time_scene.instantiate()
		var angle := randf() * TAU
		rando_position += Vector2(cos(angle), sin(angle)) * randf_range(100, 400)
		obj.position = rando_position
		obj.flash(combo_bonus_time)
		
		get_tree().create_timer(0.35).timeout.connect(func():
			add_child(obj)
		)
	
	camera.shake(0.5)
	$Player.update_score(score, points)



func _process(delta: float) -> void:
	if state == STATE_GAMEPLAY:
		time_remaining -= delta
		t_combo -= delta
		
		if t_combo < 0:
			combo = 0
		
		if time_remaining < 0:
			time_remaining = 0
			finish_game()
		
		update_timer()


func update_timer() -> void:
	$GUI/Score/Label.text = TIME_STRING % [
		floorf(time_remaining / 60),
		fmod(time_remaining, 60)
	]


func init_game() -> void:
	state = STATE_PREGAME
	$Player.position = $Castle.get_player_respawn().global_position
	$YarnSpawner.initialize()
	$Player.reset()
	
	%WinPanel.hide()
	
	time_remaining = time_per_round
	update_timer()
	
	score = 0
	$Player.set_physics_process(true)
	$Player.update_score(0, 0)


func start_game() -> void:
	state = STATE_GAMEPLAY


func finish_game() -> void:
	state = STATE_FINISHED
	print("GAME FINISHED with score ", score)
	$Player.set_physics_process(false)
	
	%WinPanel.appear(score, PauseManager.high_score)
	PauseManager.high_score = maxi(PauseManager.high_score, score)
