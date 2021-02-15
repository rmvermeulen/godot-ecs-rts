extends "res://addons/gut/test.gd"

var value := 10
var quad: QuadTreeInt


func before_each():
	quad = QuadTreeInt.new(100, 100, 2, value)


func test_child_of():
	assert_eq(QuadTreeInt.child_a_of(0), 1, "expected 1st child")
	assert_eq(QuadTreeInt.child_b_of(0), 2, "expected 2nd child")
	assert_eq(QuadTreeInt.child_c_of(0), 3, "expected 3rd child")
	assert_eq(QuadTreeInt.child_d_of(0), 4, "expected 4th child")

	assert_eq(QuadTreeInt.child_a_of(10), 41)


func test_parent_of():
	assert_eq(QuadTreeInt.parent_of(1), 0, "expected parent")
	assert_eq(QuadTreeInt.parent_of(2), 0, "expected parent")
	assert_eq(QuadTreeInt.parent_of(3), 0, "expected parent")
	assert_eq(QuadTreeInt.parent_of(4), 0, "expected parent")

	assert_eq(QuadTreeInt.parent_of(13), 3)
	assert_eq(QuadTreeInt.parent_of(41), 10)
	assert_eq(QuadTreeInt.parent_of(1000), 249)


func test_child_parent_pipe():
	for i in [10, 13, 140, 200]:
		assert_eq(i, QuadTreeInt.parent_of(QuadTreeInt.child_a_of(i)), "expected id")
		assert_eq(i, QuadTreeInt.parent_of(QuadTreeInt.child_b_of(i)), "expected id")
		assert_eq(i, QuadTreeInt.parent_of(QuadTreeInt.child_c_of(i)), "expected id")
		assert_eq(i, QuadTreeInt.parent_of(QuadTreeInt.child_d_of(i)), "expected id")


func test_create_quadtree():
	assert_eq(QuadTreeInt.new(100, 100, 1, value)._data, PoolIntArray([value]))
	assert_eq(QuadTreeInt.new(100, 100, 2, value)._data, PoolIntArray([value, 0, 0, 0, 0]))
	assert_eq(
		QuadTreeInt.new(100, 100, 3, value)._data,
		PoolIntArray([value, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
	)


func test_insert_data():
	var new_value := value + 2
	assert_true(quad.insert_int(Vector2(10, 10), new_value))
	assert_eq(quad._data, PoolIntArray([value, new_value, value, value, value]))

	assert_true(quad.insert_int(Vector2(60, 10), new_value))
	assert_eq(quad._data, PoolIntArray([value, new_value, new_value, value, value]))

	assert_true(quad.insert_int(Vector2(10, 60), new_value))
	assert_eq(quad._data, PoolIntArray([value, new_value, new_value, new_value, value]))

	assert_true(quad.insert_int(Vector2(60, 60), new_value))
	assert_eq(quad._data, PoolIntArray([value, new_value, new_value, new_value, new_value]))


func test_get_rect():
	assert_eq(quad.get_rect(0), Rect2(0, 0, 100, 100))
	assert_eq(quad.get_rect(1), Rect2(0, 0, 50, 50))
	assert_eq(quad.get_rect(2), Rect2(50, 0, 50, 50))
	assert_eq(quad.get_rect(3), Rect2(0, 50, 50, 50))
	assert_eq(quad.get_rect(4), Rect2(50, 50, 50, 50))
