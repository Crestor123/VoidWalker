extends Node2D

onready var GlobalData = get_tree().get_root().get_node("Game")
onready var input = get_parent().get_node("InputManager")
onready var tween = get_parent().get_node("Tween")

var rng = RandomNumberGenerator.new()
#The probabilities of generating a number of islands
export var singleProb = 15
export var tripleProb = 25
export var doubleProb = 60

signal spawned(finalpos)
signal numIslands(num)
signal islandType(type, num)

func _ready() -> void:
	rng.randomize()
	yield(owner, "ready")
	input.connect("genIsland", self, "spawn_helper")
	setup()

func setup():
	#Generate an island in the middle-left of the screen
	spawn_island(Vector2(270/2, 480/2), Vector2(270/2, 480/2), GlobalData.currentIsland, true)
	
func get_island_types():
	var types = []
	var folder = "res://Objects/Islands"
	var dir = Directory.new()
	dir.open(folder)
	dir.list_dir_begin(true, true)
	while true:
		var file = dir.get_next()
		if file == "":
			break
		else:
			var name = file.trim_suffix(".tscn")
			types.append(name)
			
	types.erase("start")
	return types
	
func spawn_helper():
	#Determine the number of islands to spawn, and calculate their positions
	var numIslands
	var type
	
	randomize()
	numIslands = rng.randi_range(1, 100)
	if numIslands <= singleProb:
		numIslands = 1
	elif numIslands - singleProb <= tripleProb:
		numIslands = 3
	elif numIslands - (singleProb + tripleProb) <= doubleProb:
		numIslands = 2
	
	#Temporary
	if numIslands == 3: numIslands = 1
	emit_signal("numIslands", numIslands)
	
	if numIslands == 1:
		type = spawn_island(Vector2(270 + (270/4), 480/2), Vector2(270, 480/2), "random", false)
		emit_signal("islandType", type, 0)
		
	if numIslands == 2:
		type = spawn_island(Vector2(270 + (270/4), 480/3), Vector2(270, 480/3), "random", false)
		emit_signal("islandType", type, 0)
		type = spawn_island(Vector2(270 + (270/4), 480 - (480/4)), Vector2(270, 480 - (480/4)), "random", false)
		emit_signal("islandType", type, 1)
		
	if numIslands == 3:
		type = spawn_island(Vector2(270 + (270/4), 480/2), Vector2(270, 480/2), "random", false)
		emit_signal("islandType", type, 0)
		type = spawn_island(Vector2(270 + (270/4), 480/4), Vector2(270, 480/4), "random", false)
		emit_signal("islandType", type, 1)
		type = spawn_island(Vector2(270 + (270/4), 480 - (480/4)), Vector2(270, 480 - (480/4)), "random", false)
		emit_signal("islandType", type, 2)
	
	emit_signal("numIslands", numIslands)
	
func spawn_island(pos : Vector2, finalpos : Vector2, type: String, start):
	var types = get_island_types()
	var path
	var island
	randomize()
	
	if type == "start":
		path = "res://Objects/Islands/start.tscn"
	if !type or type == "random":
		path = "res://Objects/Islands/" + types[randi() % types.size()-1] + ".tscn"
	for x in types:
		if x == type:
			path = "res://Objects/Islands/" + type + ".tscn"
		
	island = load(path).instance()
		
	add_child(island)
	island.global_position = pos
	
	if !start:
		tween.interpolate_property(island, "position", island.get_position(), finalpos, 1.0, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
		tween.start()
	
	emit_signal("spawned", pos)
	return island.type
	
