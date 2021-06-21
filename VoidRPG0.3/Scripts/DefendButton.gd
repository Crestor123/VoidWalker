extends Button

onready var UI = get_parent().get_parent().get_parent().get_parent().get_parent()
var skill = preload("res://Resources/Skills/Defend.tres")

signal skillButton(skill)

func _ready():
	connect("skillButton", UI, "skillButton")
	pass # Replace with function body.

func _pressed():
	emit_signal("skillButton", skill)
