class_name PlayerState
extends Node

signal transition_requested(state: String)

var player: Player


func _initialize() -> void: pass
func _enter() -> void: pass
func _exit() -> void: pass
func _gameplay(delta: float) -> void: pass
func _on_input(event: InputEvent) -> void: pass
func _request_focus() -> bool: return false
func _get_priority() -> int: return -1


func exit_to(state_name: String) -> void:
	transition_requested.emit(state_name)
