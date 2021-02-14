class_name PathFollowingSystem
extends System


func on_process(entities: Array, delta: float):
	if not ECS.has_component('nav-path'):
		return

	for entity in entities:
		on_process_entity(entity, delta)


func on_process_entity(entity: Entity, _delta: float):
	# TODO: update velocity based on path and position
	var velocity: Velocity = entity.get_component('velocity')
	var path: NavPath = entity.get_component('nav-path')
	if path.current_point == -1:
		entity.remove_component('nav-path')
		Logger.debug("[PathFollowingSystem] path completed for entity")
		velocity.speed = 0
	else:
		var target: Vector2 = path.points[path.current_point]
		var diff: Vector2 = target - entity.position
		if diff.length_squared() < 16:
			path.current_point += 1

		velocity.direction = diff.normalized()
		velocity.speed = 100
		# prints(entity, path, velocity)
