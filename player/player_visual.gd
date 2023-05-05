extends Node2D

#@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var sprite: AnimatedSprite2D = $Body
var player : Player


func _process(delta: float) -> void:
	var grounded := player.height < Player.COLLISION_HEIGHT
	sprite.flip_h = player.direction < 0
	$Body.position.y = player.height * -100
	$Body.z_index = 2 if !grounded else 0
#	$Particles.direction = -player.velocity
	$Particles.emitting = grounded and player.velocity.length() > 0


func on_dive() -> void:
	sprite.play("dive")
#	anim.play("dive")


func on_walk(dir: Vector2) -> void:
	if !sprite.is_playing() or sprite.animation != "run":
		sprite.play("run")
	
#	anim.play("walk")


func on_jump() -> void:
#	anim.play("jump")
	sprite.play("jump")


func on_glide() -> void:
	sprite.play("glide")


func on_landed() -> void:
	sprite.play("land")


func idle() -> void:
	if sprite.animation == "glide":
		return
	sprite.play("idle")
