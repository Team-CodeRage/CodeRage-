extends Control

onready var joinContainer = get_node("HBoxContainer/PopUpsContainer/JoinContainer")
onready var hostContainer = get_node("HBoxContainer/PopUpsContainer/HostContainer")
onready var joinLobbyVBox = get_node("HBoxContainer/PopUpsContainer/JoinContainer/JoinLobbyVBox")
onready var joinMenuVBox = get_node("HBoxContainer/PopUpsContainer/JoinContainer/JoinMenuVBox")


var scene_path_to_load
var selectedPrompt
var promptToLoad
var promptNode

func _ready():
	get_tree().connect("network_peer_connected", self, "_player_connected")
	pass

func _player_connected(id):
	print("Player connected to server!")
	Globals.playerIDs.append(id)
	joinLobbyVBox.loadPlayers()
	hostContainer.loadPlayers()
	pass

func createServer():
	if(insertPrompt()):
		hostContainer.showLobby()
		hostServer()
	pass

func hostServer():
	print("hosting network")
	var host = NetworkedMultiplayerENet.new()
	var res = host.create_server(1234,2)
	if(res != OK):
		print("Error creating server")
		return
	get_tree().set_network_peer(host)
	pass

func joinServer():
	print("joining network")
	var host = NetworkedMultiplayerENet.new()
	host.create_client(joinMenuVBox.getIP(), 1234)
	get_tree().set_network_peer(host)
	pass

func insertPrompt():
	if(selectedPrompt != null):
		promptNode = get_node("HBoxContainer/PopUpsContainer/HostContainer/PromptsContainer/ScrollContainer/2PlayerPromptSelection/" + selectedPrompt)
		promptToLoad = promptNode.promptName
		hostContainer.setThePrompt(PromptData.getPromptData(promptToLoad, "Title"))
		PromptGlobal.setInstructions(PromptData.getPromptData(promptToLoad, "Instructions"))
		PromptGlobal.setOutput(PromptData.getPromptData(promptToLoad, "Output"))
		PromptGlobal.setSolution(PromptData.getPromptData(promptToLoad, "Solution"))
		PromptGlobal.setCodeBlocks(PromptData.getPromptData(promptToLoad, "CodeBlocks"))
		return true
	return false
	pass # Replace with function body.

func _on_HostPrivateButton_button_up():
	createServer()
	pass # Replace with function body.

func _on_HostPublicButton_button_up():
	createServer()
	pass # Replace with function body.

func _on_StartButton_button_up():
	pass # Replace with function body.

func _on_CancelHostButton_button_up():
	hostContainer.showPrompts()
	pass # Replace with function body.

func _on_HostButton_button_up():
	_on_CancelHostButton_button_up()
	leaveServer()
	joinContainer.hide()
	hostContainer.show()
	
	joinLobbyVBox.hide()
	joinMenuVBox.show()
	pass # Replace with function body.

func _on_JoinButton_button_up():
	_on_CancelHostButton_button_up()
	hostContainer.hide()
	joinContainer.show()
	pass # Replace with function body.

func _on_ChangeSceneButton_button_up():
	_on_CancelHostButton_button_up()
	leaveServer()
	get_tree().change_scene("res://scenes/TitleScene.tscn")
	pass # Replace with function body.

func _on_LeaveGameButton_button_up():
	leaveServer()
	joinLobbyVBox.hide()
	joinMenuVBox.show()
	pass # Replace with function body.

func _on_ReadyUpButton_pressed():
	pass # Replace with function body.

func _on_JoinGameButton_button_up():
	joinMenuVBox.hide()
	joinLobbyVBox.show()
	joinServer()
	pass # Replace with function body.
	
func leaveServer():
	pass
