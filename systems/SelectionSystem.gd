class_name SelectionSystem
extends System

enum Action { SELECT_SINGLE, DESELECT_ALL, CHECK_RECT }

var selection_event_data = null
var next_entity_action = null
var single_selected_entity = null


func _ready():
	assert(OK == Events.connect("selected_screen_pos", self, "_on_selected_screen_pos"))
	assert(OK == Events.connect("selected_screen_rect", self, "_on_selected_screen_rect"))


func _on_selected_screen_pos(screen_pos: Vector2):
	# TODO: figure out actual world position
	selection_event_data = screen_pos


func _on_selected_screen_rect(screen_rect: Rect2):
	# TODO: figure out actual world position
	selection_event_data = screen_rect


func on_process(entities: Array, delta: float):
	if selection_event_data == null:
		return

	Logger.debug('[SelectionSystem] processing entities for event_data: %s' % selection_event_data)

	match typeof(selection_event_data):
		TYPE_VECTOR2:
			var results: Array = get_parent().get_world_2d().direct_space_state.intersect_point(
				selection_event_data, 1
			)
			if results.empty():
				next_entity_action = Action.DESELECT_ALL
			else:
				var collider = results[0].collider
				if entities.has(collider):
					next_entity_action = Action.SELECT_SINGLE
					single_selected_entity = collider
				else:
					next_entity_action = Action.DESELECT_ALL

		TYPE_RECT2:
			next_entity_action = Action.CHECK_RECT

	for entity in entities:
		on_process_entity(entity, delta)

	selection_event_data = null
	next_entity_action = null
	single_selected_entity = null


func on_process_entity(entity: Entity, _delta: float):
	Logger.trace("[SelectionSystem]: processing entity: %s" % entity)
	var c := entity.get_component('selection') as Selection

	match next_entity_action:
		Action.DESELECT_ALL:
			c.selected = false
		Action.SELECT_SINGLE:
			c.selected = entity == single_selected_entity
		Action.CHECK_RECT:
			c.selected = is_inside_rect(entity)

	if c.selected:
		Logger.debug('[SelectionSystem] entity selected: %s' % entity)


func is_inside_rect(entity: Entity) -> bool:
	assert(selection_event_data is Rect2)
	var urect := Rect2(-32, -32, 64, 64)
	urect.position += entity.position
	return urect.intersects(selection_event_data)
