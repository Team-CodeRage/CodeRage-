extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var yourTime
var otherTime

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func setTime(newTime):
	yourTime = newTime
	get_node("MarginContainer/VBoxContainer/ResultsMarginContainer/VBoxContainer/Time").text = "Your Time:  " + str(newTime)
	rpc("setOtherTime", newTime)
	pass

remote func setOtherTime(newTime):
	otherTime = newTime
	get_node("MarginContainer/VBoxContainer/ResultsMarginContainer/VBoxContainer/Time").text = "Opponent's Time:  " + str(newTime)
	pass
