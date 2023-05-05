extends Area2D

@export var x_min := -10000
@export var x_max := 10000
@export var y_min := -10000
@export var y_max := 10000
@export var zoom := 1.0


func _ready() -> void:
	area_entered.connect(
		func(area):
			var c : Camera2D = area.get_parent()
			var t := create_tween()
			t.tween_property(c, "zoom", Vector2.ONE * zoom, 0.5).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
			t.tween_property(c, "limit_left", x_min, 0.5).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
			t.tween_property(c, "limit_right", x_max, 0.5).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
			t.tween_property(c, "limit_top", y_min, 0.5).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
			t.tween_property(c, "limit_bottom", y_max, 0.5).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
			t.chain().tween_property(c, "position", Vector2(), 0.25).set_trans(Tween.TRANS_CUBIC)
	)
