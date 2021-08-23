extends Node

#Permanent Stats

#Map Stats
var currentIsland = "start"
var islandsRemaining = 10
var level = 1

#Player Stats
var playerLevel = 1
var health : int
var currentHealth : int
var strength : int
var dexterity : int
var constitution : int
var intelligence : int
var wisdom : int
var charisma : int

var playerSkills

#Temporary Player Stats
var tempStrength : int
var tempDexterity : int
var tempConstitution : int
var tempIntelligence : int
var tempWisdom : int
var tempCharisma : int

var turn : bool

#Enemy Stats
var enemyLevel = 1
var enemyHealth : int
var enemyCurrentHealth : int
var enemyStrength : int
var enemyDexterity : int
var enemyConstitution : int
var enemyIntelligence : int
var enemyWisdom : int
var enemyCharisma : int

#Temporary Enemy Stats
var tempEnemyStrength : int
var tempEnemyDexterity : int
var tempEnemyConstitution : int
var tempEnemyIntelligence : int
var tempEnemyWisdom : int
var tempEnemyCharisma : int
