class_name QuadTree
extends Reference

enum { NULL, SOLID, CLEAR }

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
	match initial_value:
		SOLID:
			_data[0] = SOLID
		CLEAR:
			_data[0] = CLEAR
		_:
			pass
	prints('data zeroed!')


func remove_rect(rect: Rect2):
	var leaves := find_leaves_below(0)
	prints(leaves)


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


func find_leaves_below(index: int) -> Array:
	var first_child := child_a_of(index)
	var is_leaf_node := _data[first_child] == NULL
	if is_leaf_node:
		return [index]
	var leaves := []
	for i in 4:
		for result in find_leaves_below(first_child + i):
			leaves.append(result)
	return leaves


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
