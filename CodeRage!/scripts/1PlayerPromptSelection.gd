extends VBoxContainer

onready var selectionItem = load("res://scenes/1PlayerSelectionItem.tscn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	loadPrompts()
	pass # Replace with function body.

func toggledButton(name):
	for i in get_children():
		if(i.get_name() != name):
			i.untoggle()
	pass # Replace with function body.

func loadPrompts():
	clearChildren()
	for prompt in PromptData.data["Prompts"].keys():
		print("Prompt: ", prompt)
		var child = selectionItem.instance()
		child.setDifficulty(int(PromptData.getPromptData(prompt, "Difficulty")))
		child.changeDescription(PromptData.getPromptData(prompt, "Title"))
		child.setStars(int(PromptData.getPromptData(prompt, "Stars")))
		add_child(child)
	pass

func clearChildren():
	for child in get_children():
		child.queue_free()
	pass
