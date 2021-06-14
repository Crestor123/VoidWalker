extends Position2D

onready var camera = get_parent()
onready var tween = $Tween
#onready var timer = $Timer
onready var input = get_parent().get_node("InputManager")

var speed = 1

func _ready():
	var start = Vector2(0, 0)
	set_global_position(start)
	input.connect("moveCamera", self, "move")
	
func _process(delta):
	pass
	
func move(pos : Vector2):
	emit_signal("ready")
	tween.interpolate_property(self, "position", get_position(), pos, 1.0, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	tween.start()
	
