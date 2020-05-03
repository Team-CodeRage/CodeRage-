extends Control

var popUp
var gridNode
var resultsNode
var moneyLabel
var blockList
var attemptList
var solution
var money = 50
var colors = [Color("#ef476f"), Color("#ffd166"), Color("#06d6a0"), Color("#118ab2")]

func _ready():
	popUp = get_node("FrontGUI/PopupDialog")
	gridNode = get_node("BackGUI/GridMarginContainer/ScrollMarginContainer/ScrollContainer/VBoxContainer")
	resultsNode = get_node("FrontGUI/2PResultsMenu")
	moneyLabel = get_node("FrontGUI/TextureRect/MoneyLabel")
	blockList = PromptGlobal.getCodeBlocks()
	print("blockList: ", blockList)
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
	get_tree().paused = false
	get_tree().network_peer.close_connection(100)
	_on_Button_pressed("res://scenes/TitleScene.tscn")
	pass # Replace with function body.

func _on_PauseButton_pressed():
	#var new_pause_state = not get_tree().paused
	#get_tree().paused = not get_tree().paused
	get_node("FrontGUI/2PPauseMenu").show()
	pass

func getBlockPos(row, col):
	return gridNode.getGridPosition(row,col)

func getTime():
	return get_node("FrontGUI/TextureRect/RichTextLabel").text

func _on_BlockUpdate_timeout():
	if(get_tree().is_network_server()):
		randomize()
		var solutionNum = randi() % blockList.size()
		var color = colors[randi() % colors.size()]
		rpc("spawnBlock", solutionNum, color)
	pass # Replace with function body.

remotesync func spawnBlock(blockNum, color):
	addMoney(2)
	var block = get_node("2PBlockManager")
	block.createSprite(blockList[blockNum], blockNum, color)
	pass

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
