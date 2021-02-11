class_name SelectionSystem
extends System

var selection_event_data = null


func _ready():
	assert(OK == Events.connect("selected_pos", self, "_on_selected_pos"))
	assert(OK == Events.connect("selected_rect", self, "_on_selected_rect"))


func _on_selected_pos(pos: Vector2):
	selection_event_data = pos


func _on_selected_rect(rect: Rect2):
	selection_event_data = rect


func on_process(entities: Array, delta: float):
	if selection_event_data == null:
		return

	Logger.debug('[SelectionSystem] processing entities for event_data: %s' % selection_event_data)

	for entity in entities:
		on_process_entity(entity, delta)

	selection_event_data = null


func on_process_entity(entity: Entity, _delta: float):
	Logger.trace("[SelectionSystem]: processing entity: %s" % entity)
	var c := entity.get_component('selection') as Selection
	c.selected = is_picked_by_event(entity)
	if c.selected:
		Logger.debug('[SelectionSystem] entity selected: %s' % entity)


func is_picked_by_event(entity: Entity) -> bool:
	var urect := Rect2(-32, -32, 64, 64)
	urect.position += entity.position

	Logger.trace('[SelectionSystem] Entity %s -> %s' % [urect, selection_event_data])

	match typeof(selection_event_data):
		TYPE_VECTOR2:
			return urect.has_point(selection_event_data)
		TYPE_RECT2:
			return urect.intersects(selection_event_data)

	return false
