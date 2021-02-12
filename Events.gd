extends Node

signal selected_pos(pos)
signal selected_rect(rect)


func _ready():
	Logger.debug('[Events] _ready')
	yield(get_tree().create_timer(1.0), "timeout")

	emit_signal("selected_pos", Vector2(266, 215))
	Logger.debug('[Events] selected_pos emitted')

	emit_signal("selected_rect", Rect2(100, 100, 400, 400))
	Logger.debug('[Events] selected_rect emitted')
