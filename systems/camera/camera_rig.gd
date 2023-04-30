extends Camera2D

@export var max_offset := Vector2(500, 350)
@export var trauma_curve : Curve

# Thanks to kidscancode for sponsoring today's multitarget system!
# https://kidscancode.org/godot_recipes/3.x/2d/multi_target_camera/index.html#full-script
@export var move_speed := 0.5  # camera position lerp speed
@export var zoom_speed := 0.25  # camera zoom lerp speed
@export var min_zoom := 1.5  # camera won't zoom closer than this
@export var max_zoom := 5.0  # camera won't zoom farther than this

@export var margin = Vector2(400, 200)  # include some buffer area around targets

@onready var screen_size = get_viewport_rect().size
var targets : Array[Node2D] = []  # Array of targets to be tracked
var weights : Array[float] = []
var trauma : float


func _process(delta: float) -> void:
	apply_shake()
	
	if targets.size() < 1:
		return
	
	var center = Vector2.ZERO
	var sum := 0.0
	for i in targets.size():
		center += targets[i].position * weights[i]
		sum += weights[i]
	center /= sum
	position = lerp(position, center, move_speed)
	
#	var r := Rect2(position, Vector2.ONE)
#	for target in targets:
#		r = r.expand(target.position)
#	r = r.grow_individual(margin.x, margin.y, margin.x, margin.y)
#
#	var zoom_fac : float
#	if r.size.x > r.size.y * screen_size.aspect():
#		zoom_fac = clampf(r.size.x / screen_size.x, min_zoom, max_zoom)
#	else:
#		zoom_fac = clampf(r.size.y / screen_size.y, min_zoom, max_zoom)
#	zoom = lerp(zoom, Vector2.ONE * zoom_fac, zoom_speed)


func apply_shake() -> void:
	if trauma > 0:
		trauma -= get_process_delta_time()
		offset = trauma_curve.sample(trauma) * max_offset * Vector2(randf_range(-1, 1), randf_range(-1, 1))
	else:
		trauma = 0


func add_target(t: Node2D, weight := 1.0) -> void:
	targets.append(t)
	weights.append(weight)

func remove_target(t: Node2D) -> void:
	var idx := targets.find(t)
	weights.remove_at(idx)
	targets.remove_at(idx)

#func set_target(new: Node2D, snap := false) -> void:
#	target = new
#
#	if snap:
#		position = new.position

func shake(p_trauma : float) -> void:
	trauma = maxf(trauma + p_trauma, p_trauma)
