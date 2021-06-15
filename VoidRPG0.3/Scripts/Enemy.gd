extends Node2D

onready var sprite = $Sprite

signal healthChanged(value)
signal statChanged(stat, value)
signal dead()

var buffs = {}

var enemyName : String
var icon : Texture

var currentHealth : int
var health : int
var strength : int
var constitution : int
var intelligence : int
var wisdom : int
var charisma : int

var skills

func initialize(enemy):
		var stats = load(enemy)
		enemyName = stats.name
		icon = stats.sprite
		sprite.texture = icon
		health = stats.health
		currentHealth = stats.health
		strength = stats.strength
		constitution = stats.constitution
		intelligence = stats.intelligence
		wisdom = stats.wisdom
		charisma = stats.charisma
		skills = stats.skills

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
