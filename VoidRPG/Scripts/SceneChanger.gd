extends Node

onready var anim = $AnimationPlayer
onready var rect = $Control/ColorRect
onready var currentScene = get_parent().get_node("CurrentScene").get_child(0)
var mapscene = "res://Scenes/Map.tscn"

signal scene_changed()

func unload_scene(path, delay = 0.5):
	pass

func change_scene(path, delay = 0.5):
	yield(get_tree().create_timer(delay), "timeout")
	anim.play("Fade")
	yield(anim, "animation_finished")
	currentScene.queue_free()
	currentScene = load(mapscene).instance()
	get_parent().add_child(currentScene)
	anim.play_backwards("Fade")
