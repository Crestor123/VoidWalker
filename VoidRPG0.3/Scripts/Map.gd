extends Node2D
class_name Game

onready var islandspawner = $IslandSpawner
onready var GlobalData = get_tree().get_root()

#Variables for island types, enemy levels, etc.
var types = [null, null, null]
var levels = [1, 1, 1]
var icons = [null, null, null]
var enemies = [null, null, null]

var upperLevel = 1
var middleLevel = 1
var lowerLevel = 1

var currentIslands
var selectedIsland

# Called when the node enters the scene tree for the first time.
func _ready():
	islandspawner.connect("islandType", self, "set_type")
	islandspawner.connect("islandLevel", self, "set_level")

func set_type(type, pos):
	if type == "start": pass
	
	types[pos] = type
	
func set_level(level, pos):
	if level == 0: pass
	
	levels[pos] = level

func get_type(islandNum):
	return types[islandNum]

func set_current_islands(num):
	currentIslands = num
	
func set_remaining_islands(level):
	#Take in level, apply function and get the number of remaining islands
	GlobalData.islandsRemaining = 10
