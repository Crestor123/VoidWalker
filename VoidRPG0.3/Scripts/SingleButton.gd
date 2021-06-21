extends TouchScreenButton

onready var island = get_parent()

signal press(resource)

func _ready():
	pass 

func _on_SingleButton_press():
	print("here")
	emit_signal("press", island.islandRes)
	pass
