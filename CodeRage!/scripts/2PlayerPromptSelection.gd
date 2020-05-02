extends VBoxContainer

onready var selectionItem = load("res://scenes/2PlayerSelectionItem.tscn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	loadPrompts()
	pass # Replace with function body.

func toggledButton(buttonName):
	for i in get_children():
		if(i.get_name() != buttonName):
			i.untoggle()
		else:
			get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().selectedPrompt = buttonName
	pass # Replace with function body.

func loadPrompts():
	clearChildren()
	for prompt in PromptData.data["Prompts"].keys():
		print("Prompt: ", prompt)
		var child = selectionItem.instance()
		child.promptName = prompt
		child.setDifficulty(int(PromptData.getPromptData(prompt, "Difficulty")))
		child.changeDescription(PromptData.getPromptData(prompt, "Title"))
		add_child(child)
	pass

func clearChildren():
	for child in get_children():
		child.queue_free()
	pass
