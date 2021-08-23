extends Node

#Dictionary to contain all skill resources and levels
var playerSkills = []

#Dictionary to contain experience points for skills
var skillXP = {}

func _ready():
	addSkill("Attack")
	addSkill("Defend")
	
func XPtoLevelSkill(level):
	return 50 * level
	
func levelUpSkill(skill):
	skill.level += 1
	skill.levelup += XPtoLevelSkill(skill.level)
	
func addXPSkill(skillName, value):
	for skill in playerSkills:
		if skill.name == skillName:
			skill.xp += value
			if skill.xp >= skill.levelup:
				levelUpSkill(skill)
		

func addSkill(skillName):
	#Find a skill resource with the given name, and add it to the dictionaries
	var skill = "res://Resources/Skills/" + skillName + ".tres"
	if ResourceLoader.exists(skill):
		playerSkills.append(
			{
				"name": skillName,
				"level": 1,
				"xp": 0,
				"levelup": XPtoLevelSkill(1),
				"id": skill
			}
		)
		#playerSkills[skill] = 1
		skillXP[skillName] = 0
	pass
