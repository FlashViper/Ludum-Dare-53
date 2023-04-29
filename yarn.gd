extends CharacterBody2D

@export var bounce_strength := 1000
@export var friction := 1500

func _ready() -> void:
	$PlayerDribble.body_entered.connect(bounce)


func _physics_process(delta: float) -> void:
	velocity = velocity.move_toward(Vector2(), friction * delta)
	move_and_slide()


func bounce(body: PhysicsBody2D) -> void:
	var direction := (position - body.position).normalized()
	var strength := bounce_strength
	
#	if "velocity" in body:
#		if body.velocity.length() > 0:
#			direction = body.velocity.normalized().project(direction)
#			strength *= body.velocity.normalized().dot(direction)
	
	velocity += direction * bounce_strength
