extends Control

export(String) var instructions
export(String) var output

# Called when the node enters the scene tree for the first time.
func _ready():
	instructions = "Write a Python program to prompt the user for two numbers, num1 and num2, and output the sum of these two numbers."
	output = "First number: 5 \nSecond number: 3 \nThe sum of 5.0 and 3.0 is 8.0"
	pass # Replace with function body.

func getInstructions():
	return instructions
	pass
	
func getOutput():
	return output
	pass
