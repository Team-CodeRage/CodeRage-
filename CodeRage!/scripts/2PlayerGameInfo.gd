extends VBoxContainer


onready var gamePromptLabel = get_node("GamePrompt/Label")
onready var playerList = get_node("PlayerNameVBox")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func setPrompt(newText):
	gamePromptLabel.text = " PROMPT: " + newText
	pass

func addPlayer(playerName):
	playerList.addPlayer(playerName)
	pass

func removePlayer(playerName):
	playerList.removePlayer(playerName)
	pass

func clearPlayers():
	playerList.clearChildren()
	pass
