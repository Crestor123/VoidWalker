extends Node2D

onready var anim = $AnimationPlayer

var type = "start"

func _ready():
	anim.play("IslandBob")
