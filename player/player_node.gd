extends CharacterBody2D

signal started_game

@export_flags_2d_physics var layers_air := 1
@export var default_state := "Movement"
@onready var layers_ground := collision_mask
@onready var states: Node = $States
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var dribble_box: Area2D = $DribbleBox
var state : Player


func _ready() -> void:
	state = Player.new()
	state.body = self
	state.visual = $Visual
	state.camera_target = $CameraTarget
	
	states.initialize(state)
	states.set_state_by_name(default_state)
	
	$States/Launch.launched.connect(
		func(): started_game.emit()
	)
	$Visual.player = state
#	$Hitboxes/Dive_Strong.hit.connect(strong_attack.unbind(2))


func _physics_process(delta: float) -> void:
	states.on_physics_process(delta)
	
	var in_air := state.height > Player.COLLISION_HEIGHT
	collision_mask = layers_air if in_air else layers_ground
	dribble_box.monitorable = !in_air
	
#	for h in $Hitboxes.get_children():
#		h.position.x = absf(h.position.x) * state.direction
	
	move_and_slide()


func reset() -> void:
	states.set_state_by_name("Launch")


func update_score(new: int, amount: int) -> void:
	%Score.update_score(new, amount)


func strong_attack() -> void:
	PauseManager.hitstop(0.2)
