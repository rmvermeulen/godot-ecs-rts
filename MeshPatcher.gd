extends Navigation2D

var shape_extents := Vector2(16, 16)
var quad := QuadTreeInt.new(1024, 600, 3, 25)


func _ready():
	prints(name, "ready", quad)


func _process(_delta: float) -> void:
	update()


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton && event.pressed:
		var shape := RectangleShape2D.new()
		shape.extents = shape_extents
		var shape_node := CollisionShape2D.new()
		shape_node.shape = shape
		var area := Area2D.new()
		area.add_child(shape_node)
		area.position = event.position
		add_child(area)


func _draw():
	var mp := get_local_mouse_position()
	var rect := Rect2(-shape_extents, 2 * shape_extents)
	rect.position += mp
	draw_rect(rect, Color.green, false)
