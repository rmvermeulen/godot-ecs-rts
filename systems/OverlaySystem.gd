class_name OverlaySystem
extends System

onready var self_2d: Node2D = self as Node

var elements := []


func on_process(entities: Array, _delta: float):
	elements = []
	for entity in entities:
		var c: Selection = entity.get_component('selection')
		if c.selected:
			elements.append(entity)
	self_2d.update()


# func on_process_entity(entity: Entity, delta: float):
# 	pass
func _draw():
	for e in elements:
		self_2d.draw_rect(Rect2(e.position.x - 32, e.position.y - 32, 64, 64), Color.green, false)
