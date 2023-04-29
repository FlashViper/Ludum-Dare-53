extends CharacterBody2D

@onready var states: Node = $States
var state : Player


func _ready() -> void:
	state = Player.new()
	state.body = self
	
	states.initialize(state)


func _physics_process(delta: float) -> void:
	states.on_physics_process(delta)
	move_and_slide()


func reset() -> void:
	states.set_state_by_name("Launch")
