extends Control

onready var tween = $Tween
onready var goButton = $VBoxContainer/HBoxContainer2/Go
onready var backButton = $VBoxContainer/HBoxContainer2/Back
onready var scene = get_parent()
onready var player = get_tree().get_root().get_node("Game/Player")

onready var charName = $VBoxContainer/HBoxContainer/Name
onready var icon = $VBoxContainer/HBoxContainer/Icon
onready var health = $VBoxContainer/Health/Value
onready var strength = $VBoxContainer/Strength/Value
onready var dexterity = $VBoxContainer/Dexterity/Value
onready var constitution = $VBoxContainer/Constitution/Value
onready var intelligence = $VBoxContainer/Intelligence/Value
onready var wisdom = $VBoxContainer/Wisdom/Value
onready var charisma = $VBoxContainer/Charisma/Value

var start = Vector2(320, 0)

signal go
signal updateStats(character)

func _ready():
	charName.text = "Ready"
	health.text = "0"
	strength.text = "0"
	dexterity.text = "0"
	constitution.text = "0"
	intelligence.text = "0"
	wisdom.text = "0"
	charisma.text = "0"
	
	goButton.connect("pressed", self, "goButton")
	backButton.connect("pressed", self, "backButton")
	connect("changeScene", scene, "changeScene")
	connect("moveUI", self, "move")
	connect("updateStats", player, "setStats")
	
	set_position(start)

func goButton():
	emit_signal("go")
	pass

func backButton():
	print("here")
	move(start)

func move(pos : Vector2):
	tween.interpolate_property(self, "rect_position", get_position(), pos, 0.5, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	tween.start()

func updateUI(character : Character):
	charName.text = character.name
	icon.texture = character.icon
	health.text = str(character.health)
	strength.text = str(character.strength)
	dexterity.text = str(character.dexterity)
	constitution.text = str(character.constitution)
	intelligence.text = str(character.intelligence)
	wisdom.text = str(character.wisdom)
	charisma.text = str(character.charisma)
	
	emit_signal("updateStats", character)
	move(Vector2(70, 0))
