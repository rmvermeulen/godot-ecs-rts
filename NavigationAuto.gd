extends Navigation2D

onready var polygon_instance: NavigationPolygonInstance = $NavigationPolygonInstance


func _ready():
	var polygon := NavigationPolygon.new()
	polygon.add_outline(
		[
			Vector2(0, 0),
			Vector2(1024, 0),
			Vector2(1024, 600),
			Vector2(0, 600),
		]
	)
	polygon.make_polygons_from_outlines()

	polygon_instance.navpoly = polygon


func subtract_rect(rect: Rect2) -> void:
	# TODO: find the colliding nav polygon(s)
	# TODO: cut out the square from the polygon
	# TODO: create the surrounding nav polygons
	prints(name, 'subtract_rect', rect)


func _process(_delta: float) -> void:
	update()


func _draw() -> void:
	draw_rect(get_current_rect(), Color.red, false)


func get_current_rect() -> Rect2:
	var mp := get_local_mouse_position()
	var rect := Rect2(0, 0, 64, 64)
	rect.position = mp - Vector2(32, 32)
	return rect


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton && event.pressed:
		match event.button_index:
			BUTTON_LEFT:
				subtract_rect(get_current_rect())
