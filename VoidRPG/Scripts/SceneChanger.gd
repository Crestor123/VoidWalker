extends CanvasLayer

onready var anim = $AnimationPlayer
onready var rect = $Control/ColorRect
onready var map = get_parent().get_node("Map")
var mapscene = "res://Scenes/Map.tscn"

signal scene_changed()

func change_scene(path, delay = 0.5):
		yield(get_tree().create_timer(delay), "timeout")
		anim.play("Fade")
		yield(anim, "animation_finished")
		map.queue_free()
		map = load(mapscene).instance()
		get_parent().add_child(map)
		anim.play_backwards("Fade")
