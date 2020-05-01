extends Control

var popUp
var gridNode
var blockList

func _ready():
	popUp = get_node("FrontGUI/PopupDialog")
	gridNode = get_node("BackGUI/GridMarginContainer/ScrollMarginContainer/ScrollContainer/VBoxContainer")
	blockList = PromptGlobal.getCodeBlocks()
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

func getBlockPos(row, col):
	return gridNode.getGridPosition(row,col)

func _on_BlockUpdate_timeout():
	randomize()
	var block = get_node("BlockManager")
	block.createSprite(blockList[randi() % blockList.size()])
	pass # Replace with function body.
