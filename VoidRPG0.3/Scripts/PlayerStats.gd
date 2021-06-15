extends Node

signal healthChanged(value)
signal statChanged(stat, value)
signal dead()

var buffs = {}

var charname : String
var icon : Texture

var currentHealth : int
var health : int
var strength : int
var constitution : int
var intelligence : int
var wisdom : int
var charisma : int

func initialize(stats : Character):
		
		health = stats.health
		currentHealth = stats.health
		strength = stats.strength
		constitution = stats.constitution
		intelligence = stats.intelligence
		wisdom = stats.wisdom
		charisma = stats.charisma

func take_damage(value):
	currentHealth -= value
	emit_signal("healthChanged", currentHealth)
	if currentHealth <= 0:
		emit_signal("dead")
		
func heal(value):
	currentHealth += value
	if currentHealth >= health:
		currentHealth = health
	emit_signal("healthChanged", currentHealth)
