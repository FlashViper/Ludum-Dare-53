extends VBoxContainer

signal item_pressed(name: String)

var tween : Tween
var items : Array[Control] = []
var current_item := -1

func _ready() -> void:
	for c in get_children():
		if c is Control:
			c.mouse_entered.connect(highlight.bind(items.size()))
#			c.mouse_exited.connect(highlight.bind(-1))
			c.gui_input.connect(on_item_input.bind(items.size()))
			items.append(c)
	
	tween = create_tween()
	tween.stop()


func on_item_input(event: InputEvent, index: int) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			press(index)


func press(index: int) -> void:
	item_pressed.emit(items[index].name)


func highlight(item: int) -> void:
	current_item = item
	tween.stop()
	
	for i in items.size():
		if i == current_item:
			animate_highlight(items[i])
		else:
			animate_default(items[i])
	
	tween.play()



func animate_default(obj: Control) -> void:
	tween.tween_property(obj, "modulate", Color.WHITE, 0.45)
	tween.tween_property(obj, "scale", Vector2.ONE, 0.35)
	tween.tween_property(obj, "rotation", 0, 0.35)


func animate_highlight(obj: Control) -> void:
	tween.tween_property(obj, "modulate", Color.YELLOW, 0.2)
	tween.tween_property(obj, "scale", Vector2.ONE * 1.1, 0.1)
	tween.tween_property(obj, "rotation_degrees", 5, 0.1)
