extends Node2D


onready var button = $Button
onready var icon = $Icon
onready var charSelectUI = get_parent().get_node("UILayer/CharacterSelectUI")
export (Resource) var character

signal select(data)

func _ready():
	icon.texture = character.icon
	button.connect("pressed", self, "select")
	connect("select", charSelectUI, "updateUI")

func select():
	emit_signal("select", character)
