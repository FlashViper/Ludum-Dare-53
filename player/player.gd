class_name Player
extends Resource

const GLIDE_SPEED := 1000
const GLIDE_ACCEL := 800
const GLIDE_COUNTERSTEER := 1000
const GLIDE_DECEL := 100
const GLIDE_SLOWDOWN := 1000

const LAUNCH_SPEED := 2000

const STARTING_HEIGHT := 50.0
const COLLISION_HEIGHT := 2.0

const FALL_RATE := 10.0
const FALL_RATE_STATIONARY := 40.0

const SPEED_WALK := 500

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
