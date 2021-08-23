extends Node2D

onready var GlobalData = get_tree().get_root().get_node("Game")
onready var input = get_parent().get_node("InputManager")
onready var tween = get_parent().get_node("Tween")
onready var data = get_parent()

var rng = RandomNumberGenerator.new()
#The probabilities of generating a number of islands
export var singleProb = 15
export var tripleProb = 25
export var doubleProb = 60

signal spawned(finalpos)
signal numIslands(num)
signal islandResource(resource, pos)
signal islandType(type, num)
signal islandLevel(level, pos)

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
	var folder = "res://Resources/Islands"
	var dir = Directory.new()
	dir.open(folder)
	dir.list_dir_begin(true, true)
	while true:
		var file = dir.get_next()
		if file == "":
			break
		else:
			var name = file.trim_suffix(".tres")
			types.append(name)
			
	types.erase("start")
	return types
	
func generate_enemy(type, level):
	#Generate a random enemy of the given type and of the given level
	#Assumes that at least 1 enemy is selected
	var enemies = []
	var selection
	var levelRange = 1 #The spawner can pull enemies with levels this far away from the given level
	var lowerLimit = level - levelRange
	if lowerLimit <= 0: lowerLimit = 1
	
	for index in range(lowerLimit, level + levelRange):
		var folder = "res://Resources/Enemies/" + (type.capitalize()) + "/" + str(level)
		var dir = Directory.new()
		dir.open(folder)
		dir.list_dir_begin(true, true)
		while true:
			var file = dir.get_next()
			if file == "":
				break
			else:
				enemies.append(folder + "/" + file)
	
	rng.randomize()
	if enemies.size() == 1:
		return enemies[0]
	else:
		selection = enemies[randi() % enemies.size()-1]
		return selection
	
func spawn_helper():
	#Determine the number of islands to spawn, and set their positions
	var numIslands
	var island
	
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
		island = spawn_island(Vector2(270 + (270/4), 480/2), Vector2(270, 480/2), "random", false)
		#Determine enemy on island
		data.types[0] = island.type
		data.icons[0] = island.icon
		data.levels[0] - island.level
		data.enemies[0] = generate_enemy(island.type, island.level)
		
	if numIslands == 2:
		island = spawn_island(Vector2(270 + (270/4), 480/3), Vector2(270, 480/3), "random", false)
		data.types[0] = island.type
		data.levels[0] = island.level
		data.icons[0] = island.icon
		data.enemies[0] = generate_enemy(island.type, island.level)
		island = spawn_island(Vector2(270 + (270/4), 480 - (480/4)), Vector2(270, 480 - (480/4)), "random", false)
		data.types[1] = island.type
		data.levels[1] = island.level
		data.icons[1] = island.icon
		data.enemies[1] = generate_enemy(island.type, island.level)
		
	if numIslands == 3:
		island = spawn_island(Vector2(270 + (270/4), 480/2), Vector2(270, 480/2), "random", false)
		data.types[0] = island.type
		data.levels[0] = island.level
		data.icons[0] = island.icon
		data.enemies[0] = generate_enemy(island.type, island.level)
		island = spawn_island(Vector2(270 + (270/4), 480/4), Vector2(270, 480/4), "random", false)
		data.types[1] = island.type
		data.levels[1] = island.level
		data.icons[1] = island.icon
		data.enemies[1] = generate_enemy(island.type, island.level)
		island = spawn_island(Vector2(270 + (270/4), 480 - (480/4)), Vector2(270, 480 - (480/4)), "random", false)
		data.types[2] = island.type
		data.levels[2] = island.level
		data.icons[2] = island.icon
		data.enemies[2] = generate_enemy(island.type, island.level)
	
	emit_signal("numIslands", numIslands)
	
func spawn_island(pos : Vector2, finalpos : Vector2, type: String, start):
	var types = get_island_types()
	var path
	var island = load("res://Objects/Island.tscn").instance()
	var islandRes
	randomize()
	
	if type == "start":
		path = "res://Resources/Islands/start.tres"
	if !type or type == "random":
		path = "res://Resources/Islands/" + types[randi() % types.size()-1] + ".tres"
	for x in types:
		if x == type:
			path = "res://Resources/Islands/" + type + ".tres"
		
	islandRes = load(path)
	add_child(island)
	connect("islandResource", island, "setup")
	emit_signal("islandResource", islandRes)
	disconnect("islandResource", island, "setup")
	island.global_position = pos
	
	
	if !start:
		tween.interpolate_property(island, "position", island.get_position(), finalpos, 1.0, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
		tween.start()
	
	emit_signal("spawned", pos)
	return island
	
