class_name Destination
extends Component

export var position := Vector2.ZERO


func on_ready():
	if not position:
		position = get_parent().get_parent().position
