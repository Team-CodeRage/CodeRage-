extends VBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func getGridPosition(row, col):
	var grid = get_node(str(row) + "/" + str(col))
	grid.available = !grid.available
	return grid.get_global_position()
