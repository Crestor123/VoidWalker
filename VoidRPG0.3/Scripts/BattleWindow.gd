extends Control

onready var data = get_parent()
onready var background = $Background
onready var enemyHealth = $HealthBar
var type

func _ready():
	type = data.currentIsland
	#Set background to the proper image
	pass 
