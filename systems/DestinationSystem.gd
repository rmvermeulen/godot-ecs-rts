class_name __System
extends System

var new_destination = null


func _input(event: InputEvent):
	if event.is_action_pressed("cmd_move_here"):
		new_destination = event.position


func on_process(entities: Array, delta: float):
	if not new_destination:
		return

	for entity in entities:
		on_process_entity(entity, delta)

	new_destination = null


func on_process_entity(entity: Entity, _delta: float):
	var selection: Selection = entity.get_component("selection")
	if not selection.selected:
		return
	var destination: Destination = entity.get_component('destination')
	destination.position = new_destination
	if entity.has_component('nav-path'):
		entity.remove_component('nav-path')
