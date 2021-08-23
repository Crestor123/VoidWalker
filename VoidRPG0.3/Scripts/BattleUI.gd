extends Control

onready var data = get_parent()
onready var playerHealth = $VBoxContainer/HealthBar
onready var skillContainer = $VBoxContainer/ScrollContainer/SkillContainer
onready var attackButton = $VBoxContainer/HBoxContainer/ColorRect/ColorRect/Attack
onready var defendButton = $VBoxContainer/HBoxContainer/ColorRect2/ColorRect/Defend

var maxHealth

signal use_skill(skill, turn)

func _ready():
	connect("use_skill", data, "useSkill")
	attackButton.connect("skillButton", self, "skillButton")
	pass

func populateSkills():
	#Populate skill container with buttons
	for skill in data.player.skills.playerSkills:
		var skillButton = load("res://Objects/Skill.tscn").instance()
		skillButton.skill = load(skill.id)
		skillContainer.add_child(skillButton)
		skillButton.connect("skillSignal", self, "skillButton")

func health_changed(value):
	playerHealth.text = String(value) + "/" + String(maxHealth)
	pass

func skillButton(skill):
	emit_signal("use_skill", skill, true)
	pass
