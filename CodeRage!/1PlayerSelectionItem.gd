extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func changeDifficulty(color, text):
	get_node("HBoxContainer/TextureRect").set_self_modulate(color)
	get_node("HBoxContainer/TextureRect/Label").setText(text)
	pass
	
func changeDescription(text):
	get_node("HBoxContainer/Description").setText(text)
	pass
	
func setStars(num):
	for i in get_node("HBoxContainer/Stars").get_children():
		if(num > 0):
			i.texture = "res://assets/star.png"
			num = num - 1
		else:
			i.texture = "res://assets/starempty.png"
	pass

func untoggle():
	$TextureButton.pressed = false
	pass

func _on_TextureButton_button_down():
	get_parent().toggledButton(self.name)
	pass # Replace with function body.
