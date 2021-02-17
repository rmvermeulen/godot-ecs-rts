extends "res://addons/gut/test.gd"

const total_tests := 6

var quad: QuadTree
var completed_tests := 0


func after_all():
	assert_eq(completed_tests, total_tests, "Not all tests completed!")


func before_each():
	quad = QuadTree.new(128, 128, 2)


func test_child_of():
	assert_eq(QuadTree.child_a_of(0), 1, "expected 1st child")
	assert_eq(QuadTree.child_b_of(0), 2, "expected 2nd child")
	assert_eq(QuadTree.child_c_of(0), 3, "expected 3rd child")
	assert_eq(QuadTree.child_d_of(0), 4, "expected 4th child")

	assert_eq(QuadTree.child_a_of(10), 41)

	completed_tests += 1


func test_parent_of():
	assert_eq(QuadTree.parent_of(1), 0, "expected parent")
	assert_eq(QuadTree.parent_of(2), 0, "expected parent")
	assert_eq(QuadTree.parent_of(3), 0, "expected parent")
	assert_eq(QuadTree.parent_of(4), 0, "expected parent")

	assert_eq(QuadTree.parent_of(13), 3)
	assert_eq(QuadTree.parent_of(41), 10)
	assert_eq(QuadTree.parent_of(1000), 249)

	completed_tests += 1


func test_child_parent_pipe():
	for i in [10, 13, 140, 200]:
		assert_eq(i, QuadTree.parent_of(QuadTree.child_a_of(i)), "expected id")
		assert_eq(i, QuadTree.parent_of(QuadTree.child_b_of(i)), "expected id")
		assert_eq(i, QuadTree.parent_of(QuadTree.child_c_of(i)), "expected id")
		assert_eq(i, QuadTree.parent_of(QuadTree.child_d_of(i)), "expected id")

	completed_tests += 1


func test_create_quadtree():
	assert_eq(QuadTree.new(128, 128, 1)._data, PoolIntArray([QuadTree.SOLID]))
	assert_eq(QuadTree.new(128, 128, 2)._data, PoolIntArray([QuadTree.SOLID, 0, 0, 0, 0]))
	assert_eq(
		QuadTree.new(128, 128, 3)._data,
		PoolIntArray([QuadTree.SOLID, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
	)

	completed_tests += 1


func test_get_rect():
	assert_eq(quad.get_rect(0), Rect2(0, 0, 128, 128))

	assert_eq(quad.get_rect(1), Rect2(0, 0, 64, 64))
	assert_eq(quad.get_rect(2), Rect2(64, 0, 64, 64))
	assert_eq(quad.get_rect(3), Rect2(0, 64, 64, 64))
	assert_eq(quad.get_rect(4), Rect2(64, 64, 64, 64))

	assert_eq(quad.get_rect(5), Rect2(0, 0, 32, 32))
	assert_eq(quad.get_rect(8), Rect2(32, 32, 32, 32))

	assert_eq(quad.get_rect(int(15e1)), Rect2(72, 0, 8, 8))
	assert_eq(quad.get_rect(int(15e2)), Rect2(6, 18, 2, 2))
	assert_eq(quad.get_rect(int(10e3)), Rect2(85, 15, 1, 1))
	assert_eq(quad.get_rect(int(10e5)), Rect2(53.125, 93.875, 0.125, 0.125))

	completed_tests += 1


func test_remove_rect_and_find_leaves():
	assert_eq_deep(quad.find_leaves_rects(), {0: Rect2(0, 0, 128, 128)})
	quad.remove_rect(Rect2(16, 16, 32, 32))
	assert_eq_deep(
		quad.find_leaves_rects(),
		{
			2: Rect2(64, 0, 64, 64),
			3: Rect2(0, 64, 64, 64),
			4: Rect2(64, 64, 64, 64),
			5: Rect2(0, 0, 32, 32),
			6: Rect2(32, 0, 32, 32),
			7: Rect2(0, 32, 32, 32),
		}
	)

	quad.remove_rect(Rect2(80, 80, 16, 16))
	assert_eq_deep(
		quad.find_leaves_rects(),
		{
			2: Rect2(64, 0, 64, 64),
			3: Rect2(0, 64, 64, 64),
			4: Rect2(64, 64, 64, 64),
			5: Rect2(0, 0, 32, 32),
			6: Rect2(32, 0, 32, 32),
			7: Rect2(0, 32, 32, 32),
		}
	)

	completed_tests += 1
