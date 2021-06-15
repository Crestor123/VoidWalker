extends Node2D

onready var charUI = $UILayer/CharacterSelectUI
onready var scene = get_parent()
onready var GlobalData = get_tree().get_root().get_node("Game")

signal changeScene(newScene)

func _ready():
	charUI.connect("go", self, "go")
	connect("changeScene", scene, "changeScene")
	
func go():
	emit_signal("changeScene", "map")
	pass
