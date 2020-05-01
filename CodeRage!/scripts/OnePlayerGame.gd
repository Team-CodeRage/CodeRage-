extends Control

var popUp
var gridNode
var resultsNode
var moneyLabel
var blockList
var attemptList
var solution
var money = 50

func _ready():
	popUp = get_node("FrontGUI/PopupDialog")
	gridNode = get_node("BackGUI/GridMarginContainer/ScrollMarginContainer/ScrollContainer/VBoxContainer")
	resultsNode = get_node("FrontGUI/ResultsMenu")
	moneyLabel = get_node("FrontGUI/TextureRect/MoneyLabel")
	blockList = PromptGlobal.getCodeBlocks()
	solution = PromptGlobal.getSolution()
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
	if(checkSolution()):
		get_tree().paused = not get_tree().paused
		resultsNode.show()
		resultsNode.setTime(getTime())
		#end game
	else:
		#show error and don't end
		print("incorrect")
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

func getTime():
	return get_node("FrontGUI/TextureRect/RichTextLabel").text

func _on_BlockUpdate_timeout():
	addMoney(2)
	randomize()
	var block = get_node("BlockManager")
	var solutionNum = randi() % blockList.size()
	block.createSprite(blockList[solutionNum], solutionNum)
	pass # Replace with function body.

func checkSolution():
	attemptList = gridNode.getAttemptData()
	var currentIndex = 0
	var correct = true
	var found = false
	if(attemptList.size() <= 0):
		return false
	for item in attemptList:
		print("item: ", item)
		print("accepts: ", solution[currentIndex])
		for answer in solution[currentIndex]:
			if(str(item) == str(answer)):
				found = true
				break
		if(found == true):
			currentIndex = currentIndex + 1
			found = false
		else:
			return false
	return true
	pass
	
func subtractMoney(cost):
	money = money - cost
	moneyLabel.text = "$" + str(money)

func addMoney(amount):
	money = money + amount
	moneyLabel.text = "$" + str(money)
