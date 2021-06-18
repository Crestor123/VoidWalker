extends Node2D

onready var topUI = $TopUI
onready var UI = $UI
onready var window = $Window
onready var enemy = $Enemy
onready var GlobalData = get_tree().get_root().get_node("Game")
onready var player = GlobalData.get_node("Player/Stats")

var turn : bool
var turnCount = 0
var currentIsland

func _ready():
	currentIsland = GlobalData.currentIsland
	enemy.initialize(GlobalData.enemy)
	player.initialize()
	pass 

func useSkill(skill, playerTurn : bool):
	#Pass in a skill resource and if it is the player's turn, and evaluate the outcome
	var damage
	var stat
	var user
	var buff = {
		"stat": "",
		"turns": 0,
		"value": 0
	}
	if playerTurn: user = player
	else: user = enemy
	
	match skill.stat:
		"health":
			stat = user.temphealth
		"strength":
			stat = user.tempstrength + user.strength
		"constitution":
			stat = user.tempconstitution + user.constitution
		"dexterity":
			stat = user.tempdexterity + user.dexterity
		"wisdom":
			stat = user.tempwisdom + user.wisdom
		"intelligence":
			stat = user.tempintelligence + user.intelligence
		"charisma":
			stat = user.tempcharisma + user.charisma
	

	damage = (skill.baseDamage + (stat * skill.multiplier))
	int(round(damage))
	buff.turns = skill.turns
	buff.value = damage
	
	if skill.type == 'buff' || skill.type == 'heal':
		#The skill will affect the user's stats positively
		match skill.targetStat:
			"health":
				user.heal(damage)
				buff.stat = "health"
			"strength":
				user.tempstrength += damage
				buff.stat = "strength"
			"constitution":
				user.tempconstitution += damage
				buff.stat = "constitution"
			"dexterity":
				user.tempdexterity += damage
				buff.stat = "dexterity"
			"wisdom":
				user.tempwisdom += damage
				buff.stat = "wisdom"
			"intelligence":
				user.tempintelligence += damage
				buff.stat = "intelligence"
			"charisma":
				user.tempcharisma += damage
				buff.stat = "charisma"
		user.buffs += buff
	pass
