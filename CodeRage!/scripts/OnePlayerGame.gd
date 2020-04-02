extends Control

var popUp
var promptNode

func _ready():
	promptNode = get_node("Prompt")
	popUp = get_node("PopupDialog")
	pass

func _on_Button_pressed(scene_to_load):
	get_tree().change_scene(scene_to_load)
	pass


func _on_InstructionsButton_pressed():
	popUp.setTitle("Instructions")
	popUp.setDescription(promptNode.getInstructions())
	popUp.popup()
	pass # Replace with function body.


func _on_OutputButton_pressed():
	popUp.setTitle("Example Output")
	popUp.setDescription(promptNode.getOutput())
	popUp.popup()
	pass # Replace with function body.


func _on_SubmitButton_pressed():
	pass # Replace with function body.


func _on_BackButton_pressed():
	get_tree().paused = not get_tree().paused
	_on_Button_pressed("res://scenes/TitleScene.tscn")
	pass # Replace with function body.


func _on_PauseButton_pressed():
	var new_pause_state = not get_tree().paused
	get_tree().paused = not get_tree().paused
	get_node("PauseMenu").show()
	pass
