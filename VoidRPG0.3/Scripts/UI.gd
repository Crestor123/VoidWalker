extends Control

onready var data = get_parent().get_parent()

onready var tween = get_parent().get_parent().get_node("Tween")
onready var input = get_parent().get_parent().get_node("InputManager")
onready var goButton = $MarginContainer/VBoxContainer/Go
onready var backButton = $MarginContainer/VBoxContainer/Back
onready var typeTag = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/Type
onready var levelTag = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/LevelValue
onready var icon = $MarginContainer/VBoxContainer/HBoxContainer/Icon

func _ready():
	input.connect("moveUI", self, "move")
	setup()
	
func setup():
	#Move UI down to ensure it stays out of frame
	rect_position.y = 900
	goButton.connect("pressed", input, "go")
	backButton.connect("pressed", input, "back")

func move(pos):
	updateUI()
	tween.interpolate_property(self, "rect_position", get_position(), pos, 0.5, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	tween.start()

func updateUI():
	#Change icon and text to match data
	if data.selectedIsland == null:
		pass
	else:
		icon.texture = data.icons[data.selectedIsland]
		typeTag.text = (data.types[data.selectedIsland]).capitalize()
		levelTag.text = str(data.levels[data.selectedIsland])
	
