extends Control

onready var joinContainer = get_node("HBoxContainer/PopUpsContainer/JoinContainer")
onready var hostContainer = get_node("HBoxContainer/PopUpsContainer/HostContainer")
onready var joinLobbyVBox = get_node("HBoxContainer/PopUpsContainer/JoinContainer/JoinLobbyVBox")
onready var joinMenuVBox = get_node("HBoxContainer/PopUpsContainer/JoinContainer/JoinMenuVBox")

const PORT        = 1234
const MAX_PLAYERS = 2
var scene_path_to_load
var selectedPrompt
var promptToLoad
var promptNode
var myID 
var hostingServer = false
var joiningServer = false

func _ready():
	get_tree().connect("network_peer_connected", self, "_client_connected")
	get_tree().connect("network_peer_disconnected", self, "_client_disconnected")
	get_tree().connect("connected_to_server", self, "_connected_ok")
	get_tree().connect("connection_failed", self, "_connected_fail")
	get_tree().connect("server_disconnected", self, "_server_disconnected")
	pass

func _client_connected(id):
	print("Player ", id, " connected to the server!")
	Globals.playerIDs.append(id)
	if(get_tree().is_network_server()):
		rpc_id(id, "register_player", Globals.playerIDs, selectedPrompt)
	updatePlayerList()
	pass

func _client_disconnected(id):
	print("Player: ", id, " disconnected from the server!")
	Globals.playerIDs.erase(id)
	updatePlayerList()
	pass

func _connected_ok():
	pass # Only called on clients, not server. Will go unused; not useful here.

func _server_disconnected():
	pass # Server kicked us; show error and abort.

func _connected_fail():
	pass # Could not even connect to server; abort.

func updatePlayerList():
	#Globals.playerIDs = get_tree().get_network_connected_peers()
	if(hostingServer == true):
		hostContainer.loadPlayers()
	elif(joiningServer == true):
		joinLobbyVBox.loadPlayers()
	pass

remote func register_player(info, prompt):
	# Get the id of the RPC sender.
#	var id = get_tree().get_rpc_sender_id()
	# Store the info
	Globals.playerIDs = info
	selectedPrompt = prompt

func _close_server():
	if(hostingServer):
		print("closed server")
		#kick players
		for i in Globals.playersIDs:
			if i != 1:
				print(i)
				rpc_id(i,"kicked", "Server Closed")
				get_tree().network_peer.disconnect_peer(i)
		Globals.playersIDs.clear()
		#Terminate server
		get_tree().network_peer.close_connection(100)
		get_tree().set_network_peer(null)
		hostingServer = false
		return true
	return false

remote func kicked(reason):
	get_tree().network_peer.disconnect_peer(myID)
	print("You have been kicked from the server, reason: ", reason)

func createServer():
	if(insertPrompt()):
		hostContainer.showLobby()
		hostServer()
	pass

func hostServer():
	print("hosting network")
	var host = NetworkedMultiplayerENet.new()
	var res = host.create_server(PORT,MAX_PLAYERS)
	if(res != OK):
		print("Error creating server")
		return
	get_tree().set_network_peer(host)
	hostingServer = true
	pass

func joinServer():
	print("joining network")
	var peer = NetworkedMultiplayerENet.new()
	peer.create_client(joinMenuVBox.getIP(), PORT)
	get_tree().set_network_peer(peer)
	joiningServer = true
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
	_close_server()
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
	if(joinMenuVBox.getIP().is_valid_ip_address()):
		joinMenuVBox.hide()
		joinLobbyVBox.show()
		joinServer()
	pass # Replace with function body.
	
func leaveServer():
	if(joiningServer):
		get_tree().network_peer.close_connection(100)
		joiningServer = false
		print("closed connection")
		return true
	return false
	pass
