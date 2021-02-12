class_name __System
extends System

# func on_process(entities: Array, delta: float):
# 	for entity in entities:
# 		on_process_entity(entity, delta)


func on_process_entity(entity: Entity, delta: float):
	# TODO: update velocity based on path and position
	var path: Path = entity.get_component('path')
	var velocity: Velocity = entity.get_component('velocity')
	pass
