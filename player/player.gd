class_name Player
extends Resource

const GLIDE_SPEED := 1000
const GLIDE_ACCEL := 800
const GLIDE_COUNTERSTEER := 1000
const GLIDE_DECEL := 100
const GLIDE_SLOWDOWN := 1000

const WALK_SPEED := 700
const WALK_BOOST := 500000
const WALK_ACCEL := 500000
const WALK_DIR_CHANGE := 10000
const GROUND_DECEL := 2100
const AIR_DECEL := 1000

const LAUNCH_SPEED := 2000

const JUMP_SPEED := 10
const JUMP_BOOST := 800
const GRAVITY := 35
const GRAVITY_GLIDE := 20
const COLLISION_HEIGHT := 1.0

const STARTING_HEIGHT := 5.0
const FALL_RATE := 1.0
const FALL_RATE_STATIONARY := 4.0

const DIVE_SPEED := 1500
const DIVE_DURATION := 0.15
const DIVE_COOLDOWN := 0.15

const AUTOTARGET_DIST := 750
const AUTOTARGET_ANGLE := deg_to_rad(50)

var body : CharacterBody2D
var visual : Node2D
var height : float
var velocity_z : float
var direction := 1

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
