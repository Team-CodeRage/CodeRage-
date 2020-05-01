extends VBoxContainer


var attemptData = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func getGridPosition(row, col):
	var grid = get_node(str(row) + "/" + str(col))
	return grid.get_global_position()

func getAttemptData():
	clearAttempt()
	var currentType
	var set = false
	for i in get_children():
		for j in i.get_children():
			if(j.available == false):
				if(set == true and j.type != currentType):
					attemptData.append(currentType)
					currentType = j.type
				elif(set == false):
					currentType = j.type
					set = true
	return attemptData

func clearAttempt():
	attemptData = []
	pass
