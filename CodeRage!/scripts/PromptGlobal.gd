extends Node

var instructions
var output
var codeBlocks
var solution

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
	
func getSolution():
	return solution
	pass

func getCodeBlocks():
	return codeBlocks
	pass

func setInstructions(new):
	instructions = new
	pass
	
func setOutput(new):
	output = new
	pass
	
func setSolution(new):
	solution = new
	pass
	
func setCodeBlocks(new):
	codeBlocks = new
	pass
