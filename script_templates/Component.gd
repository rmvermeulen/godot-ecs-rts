class_name __Component
extends Component

export (int) var EXAMPLE_CONFIG = 5

var origin = Vector2()
var example_var = 0


func _ready():
	if EXAMPLE_CONFIG:
		example_var = EXAMPLE_CONFIG
