extends Node2D


onready var button = $Button
onready var icon = $Icon
export (Resource) var character

func _ready():
	icon.texture = character.icon
