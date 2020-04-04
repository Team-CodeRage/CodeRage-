extends Control

var promptName

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func changeDifficulty(color, text):
	get_node("HBoxContainer/TextureRect").set_self_modulate(color)
	get_node("HBoxContainer/TextureRect/Label").set_text(text)
	pass

func setDifficulty(difficulty):
	match difficulty:
		0:
			changeDifficulty(Color("#65de6c"), "Easy")
		1:
			changeDifficulty(Color("#f9a66c"), "Med")
		2:
			changeDifficulty(Color("#db0038"), "Hard")
		3:
			changeDifficulty(Color("#db0038"), "Insane")
		_:
			changeDifficulty(Color("#db0038"), "Null")
	pass

func changeDescription(text):
	get_node("HBoxContainer/Description").set_text(text)
	pass
	
func setStars(num):
	if(num > 0):
		get_node("HBoxContainer/Stars/StarIcon/Icon").set_texture(load("res://assets/star.png"))
	if(num > 1):
		get_node("HBoxContainer/Stars/StarIcon2/Icon").set_texture(load("res://assets/star.png"))
	if(num > 2):
		get_node("HBoxContainer/Stars/StarIcon3/Icon").set_texture(load("res://assets/star.png"))
	pass

func untoggle():
	$TextureButton.pressed = false
	pass

func _on_TextureButton_button_down():
	get_parent().toggledButton(self.name)
	pass # Replace with function body.
