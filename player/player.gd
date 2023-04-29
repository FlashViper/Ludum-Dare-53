class_name Player
extends Resource

const GLIDE_SPEED := 1000
const GLIDE_ACCEL := 800
const GLIDE_COUNTERSTEER := 1000
const GLIDE_DECEL := 100
const GLIDE_SLOWDOWN := 1000

const WALK_SPEED := 500
const WALK_ACCEL := 3000
const GROUND_DECEL := 2100
const AIR_DECEL := 100

const LAUNCH_SPEED := 2000

const JUMP_SPEED := 10
const JUMP_BOOST := 800
const GRAVITY := 25
const COLLISION_HEIGHT := 1.0

const STARTING_HEIGHT := 5.0
const FALL_RATE := 1.0
const FALL_RATE_STATIONARY := 4.0

const DIVE_SPEED := 1500
const DIVE_DURATION := 0.15
const DIVE_COOLDOWN := 0.35

var body : CharacterBody2D
var height : float

var position : Vector2 :
	get:
		if body:
			return body.position
		else:
			return Vector2()
	set(new):
		if body:
			body.position = new


var velocity : Vector2 :
	get:
		if body:
			return body.velocity
		else:
			return Vector2()
	set(new):
		if body:
			body.velocity = new

func get_mouse_position() -> Vector2:
	if body:
		return body.get_global_mouse_position()
	else:
		return Vector2()
