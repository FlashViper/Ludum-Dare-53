extends Node

@export var title_scene : PackedScene
@export var tutorial_scene : PackedScene
@export var gameplay_scene : PackedScene
@export var secret_ending : PackedScene


var current : Node


func _ready() -> void:
	$MusicManager.play("Title")
	on_play_pressed()
#	current.play_pressed.connect(on_play_pressed)


func on_play_pressed() -> void:
#	TransitionManager.begin_transition()
#	await TransitionManager.screen_hidden
##	$MusicManager.crossfade_names("Title", "Tutorial", 0.3)
	
	set_scene(tutorial_scene)
	current.finished.connect(on_tutorial_finished)


func on_tutorial_finished() -> void:
	TransitionManager.begin_transition()
	await TransitionManager.screen_hidden
	
	
	set_scene(gameplay_scene)
	current.exit_to_secret.connect(on_secret_ending)
	current.exit_to_menu.connect(on_exit_to_menu)
	$MusicManager.crossfade_names("Title", "Gameplay")


func on_secret_ending() -> void:
	TransitionManager.begin_transition()
	await TransitionManager.screen_hidden
	
	set_scene(secret_ending)
	$MusicManager.crossfade_names("Gameplay", "Tutorial")


func on_exit_to_menu() -> void:
	TransitionManager.begin_transition()
	await TransitionManager.screen_hidden
	
	set_scene(title_scene)
	$MusicManager.crossfade_names("Gameplay", "Title")


func set_scene(new: PackedScene) -> void:
	if current:
		remove_child(current)
		current.queue_free()
		current = null
	
	if new != null:
		current = new.instantiate()
		add_child(current)
