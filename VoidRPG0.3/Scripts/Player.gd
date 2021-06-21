extends Node

var charName : String = ""

var icon : Texture

var health : int
var strength : int
var dexterity : int
var constitution : int
var intelligence : int
var wisdom : int
var charisma : int

func _ready():
	pass

func setStats(data):
	charName = data.name
	icon = data.icon
	health = data.health
	strength = data.strength
	dexterity = data.dexterity
	constitution = data.constitution
	intelligence = data.intelligence
	wisdom = data.wisdom
	charisma = data.charisma
