extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ResumeButton_pressed():
	var new_pause_state = not get_tree().paused
	get_tree().paused = new_pause_state
	visible = false
	pass
