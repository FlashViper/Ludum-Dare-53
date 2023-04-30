@tool
extends Node2D

@export var toggle := false :
	set(new):
		for c in get_children():
			c.position.x *= -1
