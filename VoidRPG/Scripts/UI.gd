extends Control

onready var data = get_parent().get_parent()

onready var tween = get_parent().get_parent().get_node("Tween")
onready var input = get_parent().get_parent().get_node("InputManager")
onready var goButton = $MarginContainer/VBoxContainer/Go
onready var backButton = $MarginContainer/VBoxContainer/Back
onready var typeTag = $MarginContainer/VBoxContainer/HBoxContainer/Type
onready var icon = $MarginContainer/VBoxContainer/HBoxContainer/Icon

var earth = preload("res://Sprites/ElementSymbols/Earth.png")

func _ready():
	input.connect("moveUI", self, "move")
	setup()
	
func setup():
	#Move UI down to ensure it stays out of frame
	rect_position.y = 900
	goButton.connect("pressed", input, "go")
	backButton.connect("pressed", input, "back")

func move(pos):
	update()
	tween.interpolate_property(self, "rect_position", get_position(), pos, 1.0, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	tween.start()

func update():
	#Change icon and text to match data
	if data.selectedIsland == null:
		pass
	elif data.types[data.selectedIsland] == "earth":
		icon.texture = earth
		typeTag.text = data.types[data.selectedIsland].capitalize()
	
