extends Node2D

@export var draw_radius := 275
@export var circle_radius := 50
@export var radius_falloff : Curve
@export var alpha_falloff : Curve
@export var base_color : Color

var yarn : Array[Dictionary] = []


func _process(delta: float) -> void:
	yarn = []
	
	for t in get_tree().get_nodes_in_group("Target"):
		yarn.append({
			"direction": (t.position - global_position).normalized(),
			"distance": (t.position - global_position).length()
		})
	
	yarn.sort_custom(func(a,b): a.distance < b.distance)
	if yarn.size() < 1 or yarn[0].distance < 1000:
		yarn = []
	queue_redraw()


func _draw() -> void:
#	draw_circle(
#		InputManager.direction_slerped * draw_radius,
#		circle_radius,
#		Color.RED
#	)
	
	var i := 0
	
	for y in yarn:
		if i > 5:
			break
		
		var distance_factor := clampf(inverse_lerp(0, 2048, y.distance), 0, 1)
		draw_circle(
			y.direction * draw_radius,
			circle_radius * radius_falloff.sample(distance_factor),
			Color(base_color, alpha_falloff.sample(distance_factor))
		)
		i += 1
