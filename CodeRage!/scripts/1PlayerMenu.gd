extends Control

var scene_path_to_load
var selectedPrompt
var promptToLoad

func _ready():
	for button in $Buttons.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])
	pass

func _on_Button_pressed(scene_to_load):
	scene_path_to_load = scene_to_load
	get_tree().change_scene(scene_path_to_load)
	pass


func _on_PlayButton_pressed():
	if(selectedPrompt != null):
		promptToLoad = get_node("VBoxContainer/PromptMarginContainer/MarginContainer/ScrollContainer/1PlayerPromptSelection/" + selectedPrompt).promptName
		PromptGlobal.setInstructions(PromptData.getPromptData(promptToLoad, "Instructions"))
		PromptGlobal.setOutput(PromptData.getPromptData(promptToLoad, "Output"))
		PromptGlobal.setSolution(PromptData.getPromptData(promptToLoad, "Solution"))
		PromptGlobal.setCodeBlocks(PromptData.getPromptData(promptToLoad, "CodeBlocks"))
		_on_Button_pressed("res://scenes/OnePlayerGame.tscn")
	else:
		pass
	pass # Replace with function body.
