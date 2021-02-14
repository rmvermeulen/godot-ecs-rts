class_name NavPath
extends Component

export (PoolVector2Array) var points := []
export (int) var current_point := -1 setget set_current_point


func get_name():
	return 'nav-path'


func set_current_point(value: int):
	if value == -1:
		current_point = value
	elif value == points.size():
		current_point = -1
	else:
		current_point = value % points.size()
