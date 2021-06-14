extends Node2D

onready var anim = $AnimationPlayer
onready var tween = $Tween
onready var sprite = $Sprite
onready var spawner = get_parent()

var type = "earth"

func _ready():
	anim.play("IslandBob")
	#spawner.connect("spawned", self, "playNextAnim")

func destroy():
	queue_free()
