extends Node

onready var GlobalData = get_tree().get_root().get_node("Game")
onready var data = get_parent()

onready var advanceButton = $CanvasLayer/TouchScreenButton
onready var goButton = get_parent().get_node("UILayer/UI/MarginContainer/VBoxContainer/Go")
onready var backButton = get_parent().get_node("UILayer/UI/MarginContainer/VBoxContainer/Back")
onready var islandSpawner = get_parent().get_node("IslandSpawner")
onready var buttonSpawner = get_parent().get_node("ButtonSpawner")
onready var cursor = get_parent().get_node("Cursor")
onready var sceneChanger = GlobalData.get_node("SceneChanger")

#UI variables
onready var menu = get_parent().get_node("UILayer/TopUI/MarginContainer/HBoxContainer/MenuButton")

signal moveCamera(pos)
signal moveCursor(pos)
signal moveUI(pos)
signal genIsland

func _ready():
	advanceButton.connect("pressed", self, "advance")
	goButton.connect("pressed", self, "go")
	backButton.connect("pressed", self, "back")
	menu.get_popup().add_item("Reset")
	menu.get_popup().connect("id_pressed", self, "menuItem")

func menuItem(id):
	var item = menu.get_popup().get_item_text(id)
	if item == 'Reset':
		reset()

func advance():
	#Send signals to create new islands, and to move the camera
	advanceButton.visible = false
	emit_signal("moveCamera", Vector2(270/4, 0))
	emit_signal("genIsland")
	
func go():
	#Load new scene
	GlobalData.currentIsland = data.types[data.selectedIsland]
	GlobalData.islandsRemaining = GlobalData.islandsRemaining - 1
	sceneChanger.change_scene("res://Scenes/Map.tscn")
	pass
	
func back():
	#Return camera to previous position
	emit_signal("moveCamera", Vector2(270/4, 0))
	emit_signal("moveUI", Vector2(0, 900))
	emit_signal("moveCursor", Vector2(270/2, 210))
	
func reset():
	advanceButton.visible = true
	for child in islandSpawner.get_children(): child.queue_free()
	for child in buttonSpawner.get_children(): child.queue_free()
	GlobalData.islandsRemaining = 10
	islandSpawner.setup()
	cursor.setup()
	emit_signal("moveCamera", Vector2(0, 0))
	emit_signal("moveUI", Vector2(0, 900))
	
	
func single_island_button():
	data.selectedIsland = 0
	emit_signal("moveCamera", Vector2(270/2, 100))
	emit_signal("moveCursor", Vector2(270, 210))
	emit_signal("moveUI", Vector2(0, 248))
	
	
func double_island_upper():
	data.selectedIsland = 0
	emit_signal("moveCamera", Vector2(270/2, 20))
	emit_signal("moveCursor", Vector2(270, 130))
	emit_signal("moveUI", Vector2(0, 248))
	
	
func double_island_lower():
	data.selectedIsland = 1
	emit_signal("moveCamera", Vector2(270/2, 220))
	emit_signal("moveCursor", Vector2(270, 330))
	emit_signal("moveUI", Vector2(0, 248))
	
