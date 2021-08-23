extends Control

onready var GlobalData = get_tree().get_root().get_child(0)

onready var islandsRemaining = $MarginContainer/HBoxContainer/VBoxContainer/Remaining
onready var level = $MarginContainer/HBoxContainer/VBoxContainer/Level
onready var input = get_parent().get_parent().get_node("InputManager")

func _ready():
	input.connect("moveUI", self, "reset")
	update()

func update():
	islandsRemaining.text = "Islands Remaining: " + String(GlobalData.islandsRemaining)
	level.text = "Level:" + String(GlobalData.level)

func reset(pos):
	update()
