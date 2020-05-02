extends VBoxContainer

onready var playerList = get_node("MarginContainer/ScrollContainer/JoinGameInfo")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass	

func loadPlayers():
	playerList.clearPlayers()
	for player in Globals.playerIDs:
		playerList.addPlayer(str(player))
	pass

func setThePrompt(newText):
	get_node("LobbyContainer/ScrollContainer/JoinGameInfo").setPrompt(newText)
	pass
