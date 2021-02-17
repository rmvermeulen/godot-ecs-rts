class_name Unit
extends Entity

# func on_init():pass


func on_ready():
	$Sprite.modulate = get_component('team').color

# func on_enter_tree():pass
# func on_exit_tree():pass
# func on_before_add():pass
# func on_after_add():pass
# func on_before_remove():pass
# func on_after_remove():pass
