extends VBoxContainer


onready var lineEditNode = get_node("MarginContainer/VBoxContainer/LineEdit")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass	
	
func getIP():
	return lineEditNode.text
	pass
