extends Node

var path = "user://data.json"

# The default values
var default_data = {
	"Prompt1" : {
		"Instructions" : "Write a Python program to prompt the user for two numbers, num1 and num2, and output the sum of these two numbers.",
		"Output" : "First number: 5 \nSecond number: 3 \nThe sum of 5.0 and 3.0 is 8.0",
		"CodeBlocks" : ["number1 = ","input(\"First number: \")","number2 =","input(\"\nSecond number: \")","sum = ","float(number1)"," + ","float(number2)","print(","The sum of {0} and {1} is {2}",".format(number1, number2, sum))"],
		"Solution" : [[0,1],
					  [2,3],
					  [4,5],
					  [6,7,8,9],
					  [10,11,12]]
		},
	"options" : {
		"music_volume" : 0.5,
		"cheat_mode" : false
		},
	"levels_completed" : [1, 2, 3]
}

var data = { }


func _ready():
	load_game()
	update_text()


func load_game():
	var file = File.new()
	
	if not file.file_exists(path):
		reset_data()
		return
	
	file.open(path, file.READ)
	
	var text = file.get_as_text()
	
	data = parse_json(text)
	
	
	file.close()


func save_game():
	var file
	
	file = File.new()
	
	file.open(path, File.WRITE)
	
	file.store_line(to_json(data))
	
	file.close()


func reset_data():
	# Reset to defaults
	data = default_data.duplicate(true)


func add_health(amount : int):
	data["player"]["health"] += amount


func update_text():
	find_node("DataText").text = JSON.print(data)


func _on_SaveButton_pressed():
	save_game()


func _on_LoadButton_pressed():
	load_game()
	update_text()


func _on_DeleteButton_pressed():
	# Delete file
	var dir = Directory.new()
	dir.remove(path)
	
	reset_data()
	
	update_text()


func _on_AddHealthButton_pressed():
	add_health(-1)
	update_text()
