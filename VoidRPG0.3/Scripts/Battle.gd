extends Node2D

onready var topUI = $TopUI
onready var UI = $UI
onready var window = $Window
onready var GlobalData = get_tree().get_root().get_node("Game")

var turn : bool
var turnCount = 0
var currentIsland = GlobalData.currentIsland

func _ready():
	pass # Replace with function body.

