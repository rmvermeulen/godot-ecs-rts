class_name MovingSystem
extends System


func on_process_entity(entity: Entity, delta: float):
	var _component = entity.get_component("velocity") as Velocity
	entity.position += _component.direction * _component.speed * delta

# func on_process(entities: Array, delta: float):
# 	pass
