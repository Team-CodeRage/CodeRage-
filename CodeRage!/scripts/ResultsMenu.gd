extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var yourTime

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func setTime(newTime):
	yourTime = newTime
	get_node("MarginContainer/VBoxContainer/ResultsMarginContainer/VBoxContainer/Time").text = "Time:  " + str(newTime)
	pass
