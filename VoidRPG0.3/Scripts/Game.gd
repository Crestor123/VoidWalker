extends Node2D

#Global Data
#Scenes
var scenes = {
	map = "res://Scenes/Map.tscn",
	title = "res://Scenes/TitleScreen.tscn",
	battle = "res://Scenes/Battle.tscn"
}

#Map Data
var currentIsland = "start"
var islandsRemaining = 10
var level = 1

#Battle Data
var enemy = null
