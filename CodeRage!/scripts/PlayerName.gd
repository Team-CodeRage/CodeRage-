extends Control

var playerName

func setName(newName):
	playerName = newName
	get_node("Label").text = newName
	pass
