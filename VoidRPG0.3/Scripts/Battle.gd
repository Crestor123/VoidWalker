extends Node2D

onready var topUI = $TopUI
onready var UI = $UI
onready var window = $Window
onready var enemy = $Enemy
onready var GlobalData = get_tree().get_root().get_node("Game")
onready var player = GlobalData.get_node("Player")
onready var playerStats = player.stats
onready var sceneChanger = GlobalData.get_node("SceneChanger")

var turn : bool
var turnCount = 1
var currentIsland

signal playerHealth(value)
signal enemyHealth(value)
signal go

func _ready():
	playerStats.connect("healthChanged", UI, "health_changed")
	playerStats.connect("dead", self, "lose")
	enemy.connect("dead", self, "win")
	enemy.connect("healthChanged", window, "health_changed")
	connect("go", sceneChanger, "change_scene")
	
	currentIsland = GlobalData.currentIsland
	enemy.initialize(GlobalData.enemy)
	playerStats.initialize()
	
	UI.maxHealth = playerStats.health
	window.maxHealth = enemy.health
	UI.playerHealth.text = String(playerStats.temphealth) + "/" + String(playerStats.health)
	window.enemyHealth.text = String(enemy.temphealth) + "/" + String(enemy.health)
	
	UI.populateSkills()
	pass 

func win():
	#Add xp from enemy killed, display new UI to continue
	GlobalData.XP = enemy.XP
	emit_signal("go", "results")
	
func lose():
	pass

func tallySkillXP(skill, value):
	if GlobalData.skillXP.size() == 0:
		GlobalData.skillXP.append({"name": skill, "value": value})
	else:
		for item in GlobalData.skillXP:
			if item.name == skill:
				item.value += value

func stepBuff():
	for buff in playerStats.buffs:
		if buff.turns == 0:
			#Remove the buff
			match buff.stat:
				"strength":
					playerStats.tempstrength -= buff.value
				"constitution":
					playerStats.tempconstitution -= buff.value
				"dexterity":
					playerStats.tempdexterity -= buff.value
				"wisdom":
					playerStats.tempwisdom -= buff.value
				"intelligence":
					playerStats.tempintelligence -= buff.value
				"charisma":
					playerStats.tempcharisma -= buff.value
			playerStats.buffs.erase(buff)
		else: buff.turns -= 1
		
	for buff in enemy.buffs:
		if buff.turns == 0:
		#Remove the buff
			match buff.stat:
				"strength":
					enemy.tempstrength -= buff.value
				"constitution":
					enemy.tempconstitution -= buff.value
				"dexterity":
					enemy.tempdexterity -= buff.value
				"wisdom":
					enemy.tempwisdom -= buff.value
				"intelligence":
					enemy.tempintelligence -= buff.value
				"charisma":
					enemy.tempcharisma -= buff.value
			enemy.erase(buff)
		else: buff.turns -= 1

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
		user = playerStats 
		target = enemy
	else: 
		user = enemy
		target = playerStats
	
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
			user.buffs.append(buff)
			
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
			user.buffs.append(buff)
	
	if playerTurn == true:
		tallySkillXP(skill.name, damage)
		#Call enemy AI and useSkill
		if enemy.temphealth > 0:
			yield(get_tree().create_timer(1.0), "timeout")
			useSkill(enemy.select_skill(turnCount), false)
			#Check for timed out buffs/debuffs
			stepBuff()
	else: turnCount += 1
