extends Control


onready var prompts = get_node("PromptsContainer")
onready var buttons = get_node("ButtonsMarginContainer")
onready var lobby = get_node("LobbyContainer")
onready var lobbyButtons = get_node("LobbyButtonsContainer")
onready var playerList = lobby.get_node("ScrollContainer/2PlayerGameInfo")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func showLobby():
	prompts.hide()
	buttons.hide()
	lobby.show()
	lobbyButtons.show()
	pass

func loadPlayers():
	playerList.clearPlayers()
	for player in Globals.playerIDs:
		playerList.addPlayer(str(player))
	pass

func showPrompts():
	lobby.hide()
	lobbyButtons.hide()
	prompts.show()
	buttons.show()
	pass

func setThePrompt(newText):
	get_node("LobbyContainer/ScrollContainer/2PlayerGameInfo").setPrompt(newText)
	pass
