extends Resource

class_name Enemy

export var name : String = "Name"

export var sprite : Texture

export var health : int
export var strength : int
export var dexterity : int
export var constitution : int
export var intelligence : int
export var wisdom : int
export var charisma : int
export var XP : int

export(Array, Resource) var skills
