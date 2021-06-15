extends Node2D

onready var GlobalData = get_parent()
onready var sceneChanger = get_parent().get_node("SceneChanger")

func _ready():
	pass 

func changeScene(newScene):
	sceneChanger.change_scene(newScene)
	pass
