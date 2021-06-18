extends Node2D

onready var sprite = $Sprite

signal healthChanged(value)
signal statChanged(stat, value)
signal dead()

var buffs =[]
var resist = []
var weak = []

var enemyName : String
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

var skills

func initialize(enemy):
	var stats = load(enemy)
	enemyName = stats.name
	icon = stats.sprite
	sprite.texture = icon
		
	health = stats.health
	strength = stats.strength
	constitution = stats.constitution
	dexterity = stats.dexterity
	intelligence = stats.intelligence
	wisdom = stats.wisdom
	charisma = stats.charisma
	skills = stats.skills
		
	temphealth = 0
	tempstrength = 0
	tempconstitution = 0
	tempdexterity = 0
	tempintelligence = 0
	tempwisdom = 0
	tempcharisma = 0

func take_damage(value):
	temphealth -= value
	emit_signal("healthChanged", temphealth)
	if temphealth <= 0:
		emit_signal("dead")
		
func heal(value):
	temphealth += value
	if temphealth >= health:
		temphealth = health
	emit_signal("healthChanged", temphealth)
