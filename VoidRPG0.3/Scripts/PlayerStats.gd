extends Node

onready var player = get_parent()

signal healthChanged(value)
signal statChanged(stat, value)
signal dead()

var buffs = []
var resist = []
var weak = []

var charname : String
var icon : Texture

var health : int
var strength : int
var constitution : int
var dexterity : int
var intelligence : int
var wisdom : int
var charisma : int

var temphealth : int
var tempstrength : int
var tempconstitution : int
var tempdexterity : int
var tempintelligence : int
var tempwisdom : int
var tempcharisma : int

func initialize():
	health = player.health
	strength = player.strength
	constitution = player.constitution
	dexterity = player.dexterity
	intelligence = player.intelligence
	wisdom = player.wisdom
	charisma = player.charisma
		
	temphealth = player.health
	tempstrength = 0
	tempconstitution = 0
	tempdexterity = 0
	tempintelligence = 0
	tempwisdom = 0
	tempcharisma = 0

func take_damage(value):
	temphealth -= value
	if temphealth < 0: temphealth = 0
	emit_signal("healthChanged", temphealth)
	if temphealth <= 0:
		emit_signal("dead")
		
func heal(value):
	temphealth += value
	if temphealth >= health:
		temphealth = health
	emit_signal("healthChanged", temphealth)
