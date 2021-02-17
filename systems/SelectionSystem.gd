class_name SelectionSystem
extends System

export var team_color := Color(40, 85, 147)

# any selection event has some data (position, rect, ...)
var _selection_event_data = null
var _selected_entities = []


func _ready():
	assert(OK == Events.connect("selected_screen_pos", self, "_on_selected_screen_pos"))
	assert(OK == Events.connect("selected_screen_rect", self, "_on_selected_screen_rect"))


func _on_selected_screen_pos(screen_pos: Vector2):
	# TODO: figure out actual world position
	_selection_event_data = screen_pos


func _on_selected_screen_rect(screen_rect: Rect2):
	# TODO: figure out actual world position
	_selection_event_data = screen_rect


func on_process(entities: Array, _delta: float):
	# only run if a selection event occorred
	if _selection_event_data == null:
		return

	Logger.debug('[SelectionSystem] processing entities for event_data: %s' % _selection_event_data)

	# check what kind of selection is happening
	match typeof(_selection_event_data):
		TYPE_VECTOR2:
			# select the first entity on this position

			var results: Array = get_parent().get_world_2d().direct_space_state.intersect_point(
				_selection_event_data, 1
			)
			var collider = null if results.empty() else results[0].collider
			select_single(entities, collider)
		TYPE_RECT2:
			var own_entities := []
			for entity in entities:
				var team: Team = entity.get_component("team")
				if team.color == team_color:
					own_entities.append(entity)

			select_rect(own_entities, _selection_event_data)

	# clear event data
	_selection_event_data = null

	prints(_selected_entities)


func deselect_all(entities: Array):
	_selected_entities = []
	for entity in entities:
		var component: Selection = entity.get_component("selection")
		component.selected = false


func select_single(entities: Array, selected_entity: Entity):
	_selected_entities = [selected_entity]
	for entity in entities:
		var component: Selection = entity.get_component("selection")
		component.selected = (entity == selected_entity)


func select_rect(entities: Array, rect: Rect2):
	_selected_entities = []
	for entity in entities:
		var component: Selection = entity.get_component("selection")

		var entity_rect := Rect2(-32, -32, 64, 64)
		entity_rect.position += entity.position
		if entity_rect.intersects(rect):
			component.selected = true
			_selected_entities.append(entity)
		else:
			component.selected = false


func get_selected_entities() -> Array:
	return _selected_entities


func on_process_entity(_entity: Entity, _delta: float):
	assert(false, "Unused method")
