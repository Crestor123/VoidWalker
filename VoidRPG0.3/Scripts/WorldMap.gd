extends Node2D

signal started
signal finished

enum Islands {EARTH}

#Locations for newly created Islands
export var triple_upper := Vector2(0, 0)
export var triple_mid := Vector2(0, 0)
export var triple_lower := Vector2(0, 0)

export var upper := Vector2(0, 0)
export var lower := Vector2(0, 0)

export var single := Vector2(0, 0)

func _ready():
	pass # Replace with function body.



#func _process(delta):
#	pass
