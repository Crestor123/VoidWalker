extends Control

onready var icon = $ColorRect2/Button/HBoxContainer/TextureRect
onready var label = $ColorRect2/Button/HBoxContainer/Label
onready var button = $ColorRect2/Button

var skill

signal skillButton(skill)

func _ready():
	icon.texture = skill.icon
	label.text = skill.name
	pass
	



func _on_Button_pressed():
	emit_signal("skillButton", skill)
	pass
