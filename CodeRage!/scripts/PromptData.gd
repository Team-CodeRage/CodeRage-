extends Node

var path = "user://coderagedata.json"

# The default values
var default_data = {
	"version": {
		"number": "0.0.0"
		},
	"volume": {
		"number": -30
		},
	"font": {
		"size" : 0
		},
	"Prompts" : {
		"Prompt1" : {
			"Title" : "Sum of two numbers",
			"Difficulty" : 0,
			"Instructions" : "Write a Python program to prompt the user for two numbers, num1 and num2, and output the sum of these two numbers.",
			"Output" : "First number: 5 \nSecond number: 3 \nThe sum of 5.0 and 3.0 is 8.0",
			"CodeBlocks" : ["number1 = ","input(\"First number: \")","number2 =","input(\"\nSecond number: \")","sum = ","float(number1)"," + ","float(number2)","print(","The sum of {0} and {1} is {2}",".format(number1, number2, sum))"],
			"Solution" : [[0,1],
						  [2,3],
						  [4,5],
						  [6,7,8,9],
						  [10,11,12]],
			"Stars" : 3
					},
		"Prompt2" : {
			"Title" : "Prompt 2",
			"Difficulty" : 0,
			"Instructions" : "Prompt 2",
			"Output" : "Prompt 2",
			"CodeBlocks" : ["number1 = ","input(\"First number: \")","number2 =","input(\"\nSecond number: \")","sum = ","float(number1)"," + ","float(number2)","print(","The sum of {0} and {1} is {2}",".format(number1, number2, sum))"],
			"Solution" : [[0,1],
						  [2,3],
						  [4,5],
						  [6,7,8,9],
						  [10,11,12]],
			"Stars" : 2
					},
		"Prompt3" : {
			"Title" : "Prompt 3",
			"Difficulty" : 1,
			"Instructions" : "Prompt 3",
			"Output" : "Prompt 3",
			"CodeBlocks" : ["number1 = ","input(\"First number: \")","number2 =","input(\"\nSecond number: \")","sum = ","float(number1)"," + ","float(number2)","print(","The sum of {0} and {1} is {2}",".format(number1, number2, sum))"],
			"Solution" : [[0,1],
						  [2,3],
						  [4,5],
						  [6,7,8,9],
						  [10,11,12]],
			"Stars" : 1
					},
		"Prompt4" : {
			"Title" : "Prompt 4",
			"Difficulty" : 2,
			"Instructions" : "Prompt 4",
			"Output" : "Prompt 4",
			"CodeBlocks" : ["number1 = ","input(\"First number: \")","number2 =","input(\"\nSecond number: \")","sum = ","float(number1)"," + ","float(number2)","print(","The sum of {0} and {1} is {2}",".format(number1, number2, sum))"],
			"Solution" : [[0,1],
						  [2,3],
						  [4,5],
						  [6,7,8,9],
						  [10,11,12]],
			"Stars" : 0
					}
		}
}

var data = { }


func _ready():
	reset_data()
	save_game()
#	update_text()
	pass


func load_game():
	print("loaded game")
	var file = File.new()
	
	if not file.file_exists(path):
		reset_data()
		save_game()
		return
	
	file.open(path, file.READ)
	
	var text = file.get_as_text()
	
	data = parse_json(text)
	
	file.close()


func save_game():
	print("Saved Game")
	var file
	
	file = File.new()
	
	file.open(path, File.WRITE)
	
	file.store_line(to_json(data))
	
	file.close()


func reset_data():
	# Reset to defaults
	data = default_data.duplicate(true)

func _on_DeleteButton_pressed():
	# Delete file
	var dir = Directory.new()
	dir.remove(path)
	
	reset_data()
	pass

func getData(section, key):
	return data[section][key]

func getPromptData(prompt, info):
	return data["Prompts"][prompt][info]

func setData(section, key, value):
	data[section][key] = value
	pass

func setPromptData(prompt, info, value):
	data["Prompts"][prompt][info] = value
	pass
