extends Node

signal selected_screen_pos(screen_pos)
signal selected_screen_rect(screen_rect)

var _drag_start_pos := Vector2()


func _ready():
	Logger.debug('[Events] _ready')


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("select_cursor"):
		_drag_start_pos = event.position

	elif event.is_action_released("select_cursor"):
		var rect := Rect2()
		rect.position = _drag_start_pos
		rect.end = event.position
		if rect.size.x > 16 || rect.size.y > 16:
			emit_signal("selected_screen_rect", rect)
		else:
			emit_signal("selected_screen_pos", _drag_start_pos)
