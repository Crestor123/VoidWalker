extends Control

onready var data = get_parent()
onready var background = $Background
onready var enemyHealth = $HealthBar
var type
var maxHealth = 0

func _ready():
	type = data.currentIsland
	#Set background to the proper image
	pass 

func health_changed(value):
	enemyHealth.text = String(value) + "/" + String(maxHealth)
	pass
