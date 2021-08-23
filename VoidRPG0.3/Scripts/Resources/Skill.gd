extends Resource

class_name Skill

export var name : String = "Skill"
export var icon : Texture
export var description : String = ""
#Types: offense, buff, debuff, heal
export var type : String = ""

export var stat : String = ""
export var targetStat : String = ""
#Elements: earth, fire, water
export var element : String = ""
export var status : String = ""
export var cost : int = 0
export var turns : int = 0
export var baseDamage : int
export var multiplier : float
export(float, 0.0, 1.0) var chance : float
