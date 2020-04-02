extends Control

var scene_path_to_load
var popUp
var promptNode

func _ready():
	promptNode = get_node("Prompt")
	popUp = get_node("PopupDialog")
	for button in $CenterContainer.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])
	pass

func _on_Button_pressed(scene_to_load):
	scene_path_to_load = scene_to_load
	get_tree().change_scene(scene_path_to_load)
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
