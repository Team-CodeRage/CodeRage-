extends Control

var popUp
var gridNode

func _ready():
	popUp = get_node("FrontGUI/PopupDialog")
	gridNode = get_node("BackGUI/GridMarginContainer/ScrollMarginContainer/ScrollContainer/VBoxContainer")
	pass

func _on_Button_pressed(scene_to_load):
	get_tree().change_scene(scene_to_load)
	pass

func _on_InstructionsButton_pressed():
	popUp.setTitle("Instructions")
	popUp.setDescription(PromptGlobal.getInstructions())
	popUp.popup()
	pass # Replace with function body.

func _on_OutputButton_pressed():
	popUp.setTitle("Example Output")
	popUp.setDescription(PromptGlobal.getOutput())
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
	get_node("FrontGUI/PauseMenu").show()
	pass

func _on_Timer_timeout():
	var block = get_node("BlockManager/CodeBlock")
	block.setPositionNode(5, 3)
	#block.setGridLength(5)
	block.setText("Block Block")
	pass # Replace with function body.

func getBlockPos(row, col):
	return gridNode.getGridPosition(row,col)
