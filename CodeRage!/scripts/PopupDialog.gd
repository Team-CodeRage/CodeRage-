extends PopupDialog

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func setTitle(text):
	get_node("MarginContainer/VBoxContainer/Title").set_text(text)
	pass
	
func setDescription(text):
	get_node("MarginContainer/VBoxContainer/Description").set_text(text)
	pass
