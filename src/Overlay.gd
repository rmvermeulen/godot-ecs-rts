extends Node2D

export (int, 1, 200) var cursor_type := 39 setget set_cursor_type
export (Color) var cursor_color := Color.white setget set_cursor_color

var drag_screen_rect = null


func _ready() -> void:
	assert(OK == Events.connect("pre_select_screen_rect", self, "_on_pre_select_screen_rect"))
	set_cursor_type(cursor_type)
	# Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _process(_delta: float) -> void:
	update()


func _input(event: InputEvent) -> void:
	# TODO: remove
	if event is InputEventMouseButton && event.pressed:
		match event.button_index:
			BUTTON_WHEEL_DOWN:
				self.cursor_type -= 1
			BUTTON_WHEEL_UP:
				self.cursor_type += 1


func set_cursor_type(value: int) -> void:
	if value < 1 && value > 200:
		return
	cursor_type = value
	var tex: Texture = load("res://assets/crosshair-pack/crosshair%03d.png" % cursor_type)
	Input.set_custom_mouse_cursor(tex, 0, Vector2(32, 32))


func set_cursor_color(value: Color) -> void:
	cursor_color = value
	update()


func _draw() -> void:
	# draw selection box
	if drag_screen_rect:
		draw_rect(drag_screen_rect, Color.green, false)
		drag_screen_rect = null


func _on_pre_select_screen_rect(screen_rect: Rect2):
	drag_screen_rect = screen_rect
