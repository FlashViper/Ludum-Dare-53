extends CharacterBody2D

@onready var states: Node = $States
@onready var collision: CollisionShape2D = $CollisionShape2D
var state : Player


func _ready() -> void:
	state = Player.new()
	state.body = self
	
	states.initialize(state)
	states.set_state_by_name("Movement")
	
	$Visual.player = state


func _physics_process(delta: float) -> void:
	states.on_physics_process(delta)
	
	collision.disabled = state.height > Player.COLLISION_HEIGHT
	move_and_slide()


func reset() -> void:
	states.set_state_by_name("Launch")
