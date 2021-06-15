extends Node2D

onready var topUI = $TopUI
onready var UI = $UI
onready var window = $Window
onready var enemy = $Enemy
onready var GlobalData = get_tree().get_root().get_node("Game")

var turn : bool
var turnCount = 0
var currentIsland

func _ready():
	currentIsland = GlobalData.currentIsland
	enemy.initialize(GlobalData.enemy)
	pass 

