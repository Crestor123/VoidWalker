extends Area2D

onready var anim = $AnimationPlayer
onready var cursor = $Sprite
onready var tween = $Tween
onready var input = get_parent().get_node("InputManager")

func _ready():
	input.connect("moveCursor", self, "move")
	setup()

func setup():
	var start = Vector2(270/2, 210)
	#Move the cursor to the first island
	set_position(start)
	anim.play("CursorBob")
	pass

func move(pos : Vector2):
	anim.play("Blank")
	tween.interpolate_property(self, "position", get_position(), pos, 1.0, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	tween.start()
	anim.play("CursorBob")

