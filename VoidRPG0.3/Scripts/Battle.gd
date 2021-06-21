extends Node2D

onready var topUI = $TopUI
onready var UI = $UI
onready var window = $Window
onready var enemy = $Enemy
onready var GlobalData = get_tree().get_root().get_node("Game")
onready var player = GlobalData.get_node("Player/Stats")

var turn : bool
var turnCount = 1
var currentIsland

signal playerHealth(value)
signal enemyHealth(value)

func _ready():
	player.connect("healthChanged", UI, "health_changed")
	enemy.connect("healthChanged", window, "health_changed")
	
	currentIsland = GlobalData.currentIsland
	enemy.initialize(GlobalData.enemy)
	player.initialize()
	
	UI.maxHealth = player.health
	window.maxHealth = enemy.health
	UI.playerHealth.text = String(player.temphealth) + "/" + String(player.health)
	window.enemyHealth.text = String(enemy.temphealth) + "/" + String(enemy.health)
	pass 

func useSkill(skill, playerTurn : bool):
	#Pass in a skill resource and if it is the player's turn, and evaluate the outcome
	var damage
	var stat
	var user
	var target
	var buff = {
		"stat": "",
		"turns": 0,
		"value": 0
	}
	if playerTurn: 
		user = player 
		target = enemy
	else: 
		user = enemy
		target = player
	
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
		if skill.turns > 0:
			user.buffs += buff
			
	if skill.type == 'offense' || skill.type == 'debuff':
		#The skill will affect the target's stats negatively
		match skill.targetStat:
			"health":
				target.take_damage(damage)
				buff.stat = "health"
			"strength":
				target.tempstrength -= damage
				buff.stat = "strength"
			"constitution":
				target.tempconstitution -= damage
				buff.stat = "constitution"
			"dexterity":
				target.tempdexterity -= damage
				buff.stat = "dexterity"
			"wisdom":
				target.tempwisdom -= damage
				buff.stat = "wisdom"
			"intelligence":
				target.tempintelligence -= damage
				buff.stat = "intelligence"
			"charisma":
				target.tempcharisma -= damage
				buff.stat = "charisma"
		if skill.turns > 0:
			buff.value = -(damage)
			user.buffs += buff
	
	if playerTurn == true:
		#Call enemy AI and useSkill
		yield(get_tree().create_timer(1.5), "timeout")
		useSkill(enemy.select_skill(turnCount), false)
	else: turnCount += 1
