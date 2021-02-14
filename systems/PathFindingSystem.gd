class_name PathFindingSystem
extends System

# func on_process(entities: Array, delta: float):
# 	for entity in entities:
# 		on_process_entity(entity, delta)


func on_process_entity(entity: Entity, _delta: float):
	if entity.has_component('nav-path'):
		return
	# TODO: find new path for this entity
	# for now, just create a start-end path
	var destination: Destination = entity.get_component('destination')
	if entity.position.distance_squared_to(destination.position) < 16:
		return

	var path := NavPath.new()
	path.points = [
		entity.position,
		destination.position,
	]
	path.current_point = 0
	entity.add_component(path)
