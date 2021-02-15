class_name QuadTree
extends Reference

var _data := PoolIntArray()
var _width: int
var _height: int


func _init(width: int, height: int, max_depth: int, initial_value: int):
	assert(width > 0, "width must be larger than 0")
	assert(height > 0, "height must be larger than 0")
	assert(max_depth > 0, "max_depth must be larger than 0")
	_width = width
	_height = height

	var total := 0
	for i in max_depth:
		var step := pow(4, i)
		total += int(step)

	prints("max_depth = %d -> total size = %d" % [max_depth, total])

	_data.resize(total)
	for i in total:
		_data[i] = 0
	_data[0] = initial_value
	prints('data zeroed!')


func insert_int(pos: Vector2, value: int, depth := 0) -> bool:
	return false
	var index := 0
	var center := Vector2(_width, _height) / 2
	while true:
		# check stuff
		var current_value = _data[index]
		var node_is_leaf = child_a_of(index) == 0
		if node_is_leaf:
			# split node
			# set current_value on children
			pass
		else:
			# go to children
			pass

		depth += 1
		index += pow(4, depth)
	return true


func get_rect(index: int) -> Rect2:
	if index == 0:
		return Rect2(0, 0, _width, _height)

	var parent := parent_of(index)
	var rect := get_rect(parent)
	var child_index = index - child_a_of(parent)
	var w := rect.size.x / 2
	var h := rect.size.y / 2
	match child_index:
		0:
			return rect.grow_individual(0, 0, -w, -h)
		1:
			return rect.grow_individual(-w, 0, 0, -h)
		2:
			return rect.grow_individual(0, -h, -w, 0)
		3:
			return rect.grow_individual(-w, -h, 0, 0)

	assert(false, "Invalid index")
	return Rect2()


static func child_a_of(index: int) -> int:
	return (4 * index) + 1

static func child_b_of(index: int) -> int:
	return (4 * index) + 2

static func child_c_of(index: int) -> int:
	return (4 * index) + 3

static func child_d_of(index: int) -> int:
	return (4 * index) + 4

static func parent_of(index: int) -> int:
	return int((index - 1) / 4.0)

static func depth_of(index: int) -> int:
	if index == 0:
		return 0
	index = parent_of(index)
	return 1 + depth_of(index) if index else 1
