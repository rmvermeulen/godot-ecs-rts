extends Node2D

export (int, 1, 200) var cursor_type := 39 setget set_type
export (Color) var cursor_color := Color.white
var cursor_texture: Texture = null

var drag_screen_rect = null


func _ready() -> void:
	assert(OK == Events.connect("pre_select_screen_rect", self, "_on_pre_select_screen_rect"))
	set_type(cursor_type)


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


func set_type(value: int) -> void:
	if value >= 1 && value <= 200:
		cursor_type = value
		cursor_texture = load("res://assets/crosshair-pack/crosshair%03d.png" % cursor_type)


func _draw() -> void:
	# draw cursor
	var mp := get_local_mouse_position()
	if cursor_texture:
		draw_texture(cursor_texture, mp - Vector2(32, 32), cursor_color)
	# draw selection box
	if drag_screen_rect:
		draw_rect(drag_screen_rect, Color.green, false)
		drag_screen_rect = null


func _on_pre_select_screen_rect(screen_rect: Rect2):
	drag_screen_rect = screen_rect
