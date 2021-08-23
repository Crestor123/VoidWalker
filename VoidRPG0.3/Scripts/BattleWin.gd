extends Node2D

onready var GlobalData = get_tree().get_root().get_node("Game")
onready var goButton = $Button
onready var XPLabel = $Label
onready var skillXPContainer = $ScrollContainer
onready var sceneChanger = GlobalData.get_node("SceneChanger")

signal go

func _ready():
	goButton.connect("pressed", self, "go")
	connect("go", sceneChanger, "change_scene")
	pass 

func go():
	emit_signal("go", "map")
	pass

