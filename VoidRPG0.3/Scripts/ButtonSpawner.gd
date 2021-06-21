extends Node2D

var singleButton = preload("res://Objects/Buttons/SingleButton.tscn")

onready var input = get_parent().get_node("InputManager")
onready var islandSpawner = get_parent().get_node("IslandSpawner")

func _ready():
	pass 

func spawn_button(num):
	var button
	
	if num == 1:
		#Spawn single button
		button = singleButton.instance()
		add_child(button)
		button.connect("pressed", input, "single_island_button")
		button.set_position(Vector2(207, 200))
		
	if num == 2:
		#Spawn 2 buttons
		button = singleButton. instance()
		add_child(button)
		button.connect("pressed", input, "double_island_upper")
		button.set_position(Vector2(207, 120))
		
		button = singleButton.instance()
		add_child(button)
		button.connect("pressed", input, "double_island_lower")
		button.set_position(Vector2(207, 320))
