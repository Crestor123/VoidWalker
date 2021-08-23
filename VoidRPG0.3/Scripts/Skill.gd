extends Control

onready var icon = $ColorRect2/Button/HBoxContainer/TextureRect
onready var label = $ColorRect2/Button/HBoxContainer/Name
onready var cost = $ColorRect2/Button/HBoxContainer/Cost
onready var button = $ColorRect2/Button

var skill

signal skillSignal(skill)

func _ready():
	icon.texture = skill.icon
	label.text = skill.name
	if skill.cost > 0:
		cost.text = "(" + String(skill.cost) + ")"
	else:
		cost.text = ""

func _on_Button_pressed():
	emit_signal("skillSignal", skill)
