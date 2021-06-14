extends Node2D

onready var anim = $AnimationPlayer
onready var tween = $Tween
onready var sprite = $Sprite
onready var spawner = get_parent()

var islandRes
var type
var enemy = false
var level = 1
var icon

func _ready():
	anim.play("IslandBob")
	#spawner.connect("spawned", self, "playNextAnim")
	
func setup(resource, pos = 0):
	sprite.texture = resource.sprite
	icon = resource.icon
	type = resource.type
	enemy = resource.enemy
	pass

func destroy():
	queue_free()
