extends CharacterBody2D

@export var palette : ColorPalette
@export var bounce_strength := 1000
@export_range(0, 1) var bounce_decay := 0.8
@export var friction := 1500
@export var roll_speed : Curve

var t_animation : float

func _ready() -> void:
	$PlayerDribble.area_entered.connect(bounce)
	
	var color := palette.get_random()
	%Ball.modulate = color
	%HitParticles.color = color


func _physics_process(delta: float) -> void:
	velocity = velocity.move_toward(Vector2(), friction * delta)
	
	var speed := roll_speed.sample(velocity.length() / bounce_strength)
	t_animation += speed * delta * 10
	%Ball.frame = wrapi(floori(t_animation), 1, 4)
	
	var collision_info := move_and_collide(velocity * delta)
	if collision_info:
#		$BumpSound.play()
		
		velocity = velocity.bounce(collision_info.get_normal())
		velocity *= bounce_decay
		squoosh(collision_info.get_normal(), velocity.length())


func bounce(area: Area2D) -> void:
	if !area.is_in_group(&"PushBox"):
		return
	
	var direction := area._get_direction(self) as Vector2
	var strength := area._get_strength() as float
	area.on_hit(direction, strength)
	velocity += direction * strength
	
	bounce_effect(direction, strength)


func bounce_effect(direction: Vector2, strength: float) -> void:
	$BumpSound.play()
	play_yarn_particles(direction)
	squoosh(direction, strength)
	


func squoosh(direction: Vector2, strength: float) -> void:
	var t := create_tween().set_parallel(true)
	var strength_fac := clampf(strength / 3000, 0, 1)
	%BallRoot.rotation = direction.angle()
	%BallRoot.position.y = -30
	%Ball.rotation = -direction.angle()
	
	%BallRoot.scale = Vector2(1 - strength_fac, 1 + strength_fac).abs()
	
	t.tween_property(
		%BallRoot, "scale", 
		Vector2(1 + strength_fac, 1 - strength_fac), 0.1
	).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUART)
	t.chain().tween_property(
		%BallRoot, "scale", 
		Vector2(1, 1), 0.75 * strength_fac
	).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	t.chain().tween_callback(func():
		%BallRoot.rotation = 0
		%Ball.rotation = 0
	)
	
	await get_tree().create_timer(0.25).timeout
	%Anim.play("bounce")


func play_yarn_particles(direction: Vector2) -> void:
	%HitParticles.direction = direction
	%HitParticles.restart()
